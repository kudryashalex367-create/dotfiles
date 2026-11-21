#!/usr/bin/env bash
# AGY security guard hook — проверка разрешений для agy
# Читает JSON из stdin, пишет решение в stdout
set -u

input=$(cat)

python3 - "$input" <<'PY'
import os, sys, re, shlex, json

raw_input = sys.argv[1] if len(sys.argv) > 1 else ""

def reply(decision, reason=""):
    print(json.dumps({"decision": decision, "reason": reason}, ensure_ascii=False))
    sys.exit(0)

try:
    data = json.loads(raw_input)
    tool_call = data.get("toolCall", {})
    tool_name = tool_call.get("name", "run_command")
    tool_args = tool_call.get("args", {})
    cmd = tool_args.get("CommandLine", "")
except Exception as e:
    reply("ask", f"hook error: {e}")

# 1. MCP tools check
if tool_name in ("call_mcp_tool",) or tool_name.startswith("mcp_") or tool_name.startswith("git_") or tool_name == "fetch":
    server = tool_args.get("ServerName", "")
    tool = tool_args.get("ToolName", tool_name)
    tool_lower = tool.lower()

    # git MCP: commit and mutating operations require confirmation according to AGENTS.md
    if server == "git" or tool_name.startswith("git_") or tool_name.startswith("mcp_git"):
        mutating = ("commit", "push", "reset", "clean", "checkout", "merge", "rebase")
        if any(m in tool_lower for m in mutating):
            reply("ask", f"git-мутация через MCP ({tool}) требует подтверждения по правилам AGENTS.md")
        reply("allow", f"MCP git {tool} разрешён")

    # fetch MCP: ask for confirmation to protect against indirect prompt injection
    if server == "fetch" or tool in ("fetch", "mcp_fetch") or tool_name in ("fetch", "mcp_fetch"):
        reply("ask", "MCP fetch загружает внешнюю страницу (риск prompt injection), требуется подтверждение")

    # horizon MCP: allow safe launcher
    if server == "horizon" or tool_name.startswith("horizon_") or tool_name.startswith("mcp_horizon"):
        reply("allow", "horizon MCP разрешён")

    reply("allow", f"MCP tool {tool} разрешён")

# 2. File tool checks (read_file, write_file, edit_file)
if tool_name in ("read_file", "write_file", "edit_file"):
    fpath = tool_args.get("Path", "")
    if fpath:
        # Check secrets
        if any(s in fpath for s in (".zshrc_secrets", ".ssh", ".gnupg")):
            reply("deny", f"доступ к секретам ({fpath}) запрещён")
        if re.search(r'(^|[\s/])\.env(\.[a-zA-Z0-9_-]+)?(\b|[\s"\']|$)', fpath):
            reply("deny", f"доступ к .env файлам запрещён ({fpath})")

        # .gemini check
        if ".gemini" in fpath:
            norm = os.path.realpath(os.path.abspath(os.path.expanduser(fpath)))
            allowed_repo = os.path.realpath(os.path.expanduser("~/dotfiles/ai/.gemini"))
            allowed_builtin = os.path.realpath(os.path.expanduser("~/.gemini/antigravity-cli/builtin"))
            allowed_brain = os.path.realpath(os.path.expanduser("~/.gemini/antigravity-cli/brain"))
            is_allowed = (
                norm.startswith(allowed_repo + "/") or norm == allowed_repo or
                norm.startswith(allowed_builtin + "/") or norm == allowed_builtin or
                norm.startswith(allowed_brain + "/") or norm == allowed_brain
            )
            if not is_allowed:
                reply("deny", "доступ к ~/.gemini запрещён (разрешена только копия в репозитории ai/.gemini/)")

        # write_file / edit_file restrictions: only inside ~/dotfiles (or brain/tmp)
        if tool_name in ("write_file", "edit_file"):
            norm = os.path.realpath(os.path.abspath(os.path.expanduser(fpath)))
            dotfiles_dir = os.path.realpath(os.path.expanduser("~/dotfiles"))
            allowed_brain = os.path.realpath(os.path.expanduser("~/.gemini/antigravity-cli/brain"))
            tmp_dir = "/tmp"
            is_allowed = (
                norm.startswith(dotfiles_dir + "/") or norm == dotfiles_dir or
                norm.startswith(allowed_brain + "/") or norm == allowed_brain or
                norm.startswith(tmp_dir + "/") or norm == tmp_dir
            )
            if not is_allowed:
                reply("deny", f"правка файлов вне ~/dotfiles запрещена ({fpath})")
    reply("allow", f"{tool_name} разрешён")

# Non-command tools
if tool_name != "run_command":
    reply("allow", f"{tool_name} разрешён")

# 3. run_command checks
if not cmd or not cmd.strip():
    reply("allow", "empty command")

cmd = cmd.strip()

# Check base64 decode piped to shell or interpreter
if re.search(r'(base64\s+(-d|--decode)|openssl\s+enc\s+-d).*\|\s*(sh|bash|zsh|python[0-9.]*|perl|ruby|eval)', cmd):
    reply("deny", "выполнение декодированных команд через pipe запрещено")

# Check secrets in raw command string
if re.search(r'(^|[\s/"\'])(\.?zshrc_secrets)(\b|[\s/"\'])', cmd):
    reply("deny", "доступ к секретам (.zshrc_secrets) запрещён")
if re.search(r'(^|[\s/"\'])(~?/\.ssh|\.ssh/)', cmd):
    reply("deny", "доступ к секретам (.ssh) запрещён")
if re.search(r'(^|[\s/"\'])(~?/\.gnupg|\.gnupg/)', cmd):
    reply("deny", "доступ к секретам (.gnupg) запрещён")

# .env files: .env, .env.local, etc.
if re.search(r'(^|[\s/])\.env(\.[a-zA-Z0-9_-]+)?(\b|[\s"\']|$)', cmd):
    reply("deny", "доступ к .env файлам запрещён")

# .gemini check: forbidden unless inside ~/dotfiles/ai/.gemini/
gemini_matches = list(re.finditer(r'([^\s"\']*\.gemini[^\s"\']*)', cmd))
for m in gemini_matches:
    path_str = m.group(1)
    if path_str.startswith("ai/.gemini/") or path_str.startswith("./ai/.gemini/"):
        continue
    full = os.path.realpath(os.path.abspath(os.path.expanduser(path_str)))
    allowed_prefix = os.path.realpath(os.path.expanduser("~/dotfiles/ai/.gemini"))
    if not (full.startswith(allowed_prefix + "/") or full == allowed_prefix):
        reply("deny", "доступ к ~/.gemini запрещён (разрешена только копия в репозитории ai/.gemini/)")

# Segment command (respecting quotes, splitting on ;, &&, ||, |, \n, $(, `, and & not preceded by > or <)
pattern = r'(\&\&|\|\||;|\||\n|\$\(|\`|(?<![><])\&(?![><]))'

def split_segments(command_str):
    segments = []
    current = []
    in_single = False
    in_double = False
    i = 0
    while i < len(command_str):
        c = command_str[i]
        if c == "'" and not in_double:
            in_single = not in_single
            current.append(c)
            i += 1
        elif c == '"' and not in_single:
            in_double = not in_double
            current.append(c)
            i += 1
        elif not in_single and not in_double:
            m = re.match(pattern, command_str[i:])
            if m:
                seg_text = "".join(current).strip()
                if seg_text:
                    segments.append(seg_text)
                current = []
                i += len(m.group(0))
            else:
                current.append(c)
                i += 1
        else:
            current.append(c)
            i += 1
    if current:
        seg_text = "".join(current).strip()
        if seg_text:
            segments.append(seg_text)
    return segments

segments = split_segments(cmd)
secret_file_pat = re.compile(r'(^|[\s/])([a-zA-Z0-9_-]*(secret|password|credential)[a-zA-Z0-9_-]*\.[a-zA-Z0-9]+)(\b|[\s"\']|$)', re.I)

has_ask = False
ask_reason = ""

def check_segment_tokens(cmd_tokens):
    global has_ask, ask_reason
    if not cmd_tokens:
        return

    base_bin = os.path.basename(cmd_tokens[0])

    # Unroll wrappers like bash -c, sh -c, zsh -c
    if base_bin in ("bash", "sh", "zsh", "dash") and len(cmd_tokens) > 1:
        if "-c" in cmd_tokens:
            c_idx = cmd_tokens.index("-c")
            if c_idx + 1 < len(cmd_tokens):
                inner_cmd = cmd_tokens[c_idx + 1]
                inner_segs = split_segments(inner_cmd)
                for iseg in inner_segs:
                    try:
                        itoks = shlex.split(iseg)
                    except Exception:
                        itoks = iseg.split()
                    itoks = strip_wrappers(itoks)
                    check_segment_tokens(itoks)
                return

    # Unroll eval
    if base_bin == "eval" and len(cmd_tokens) > 1:
        inner_cmd = " ".join(cmd_tokens[1:])
        inner_segs = split_segments(inner_cmd)
        for iseg in inner_segs:
            try:
                itoks = shlex.split(iseg)
            except Exception:
                itoks = iseg.split()
            itoks = strip_wrappers(itoks)
            check_segment_tokens(itoks)
        return

    # Interpreters with inline code (-c, -e)
    if base_bin in ("python", "python3", "python3.11", "python3.12", "python3.13", "node", "perl", "ruby"):
        for opt in ("-c", "-e"):
            if opt in cmd_tokens:
                opt_idx = cmd_tokens.index(opt)
                if opt_idx + 1 < len(cmd_tokens):
                    code = cmd_tokens[opt_idx + 1]
                    # Check secrets
                    if re.search(r'(\.?zshrc_secrets|\.ssh|\.gnupg|\.env)', code):
                        reply("deny", "доступ к секретам внутри inline-скрипта запрещён")
                    if ".gemini" in code and "ai/.gemini" not in code:
                        reply("deny", "доступ к ~/.gemini внутри inline-скрипта запрещён")
                    # Check system command execution from script
                    exec_pat = r'(os\.(system|popen|spawn)|subprocess\.|pty\.spawn|commands\.get|child_process|execSync|spawnSync)'
                    if re.search(exec_pat, code):
                        reply("deny", "вызов системных команд из inline-скрипта запрещён")
                    # Check base64 decoding
                    if re.search(r'(b64decode|base64\.b64decode|Buffer\.from\(.*base64)', code):
                        reply("deny", "base64-декодирование внутри inline-скрипта запрещено")
                    # Check red-line commands inside string
                    if re.search(r'\b(sudo|su|doas|pacman|yay|paru|chsh)\b', code):
                        reply("deny", "запрещённая команда (sudo/pacman/etc) внутри inline-скрипта")

    if base_bin in ("sudo", "su", "doas", "pacman", "yay", "paru", "chsh"):
        reply("deny", f"{base_bin} запрещён")

    if base_bin == "printenv":
        reply("deny", "printenv запрещён")
    if base_bin == "env" and len(cmd_tokens) == 1:
        reply("deny", "голый env запрещён")

    if base_bin == "systemctl":
        if "--user" not in cmd_tokens:
            reply("deny", "systemctl без --user запрещён")

    if base_bin == "rm":
        is_recursive = False
        targets = []
        for t in cmd_tokens[1:]:
            if t.startswith("-"):
                if t in ("--recursive", "-r", "-R") or ("r" in t and "f" in t) or ("r" in t):
                    is_recursive = True
            else:
                targets.append(t)
        if is_recursive:
            if not targets:
                reply("deny", "rm с рекурсивным удалением без явной цели запрещён")
            dotfiles_dir = os.path.realpath(os.path.expanduser("~/dotfiles"))
            backup_dir = os.path.realpath(os.path.expanduser("~/dotfiles-backup"))
            for tgt in targets:
                norm = os.path.realpath(os.path.abspath(os.path.expanduser(tgt)))
                if not (norm.startswith(dotfiles_dir + "/") or norm.startswith(backup_dir + "/") or norm == dotfiles_dir or norm == backup_dir):
                    reply("deny", f"рекурсивное удаление вне dotfiles/dotfiles-backup запрещено ({tgt})")

    if base_bin == "git":
        g_idx = 1
        while g_idx < len(cmd_tokens):
            gt = cmd_tokens[g_idx]
            if gt in ("-C", "-c") and g_idx + 1 < len(cmd_tokens):
                g_idx += 2
            elif gt.startswith("-"):
                g_idx += 1
            else:
                break
        if g_idx < len(cmd_tokens):
            subcmd = cmd_tokens[g_idx]
            subargs = cmd_tokens[g_idx+1:]

            if subcmd == "push":
                for a in subargs:
                    if a in ("--force", "-f", "--force-with-lease", "--tags", "--mirror") or a.startswith("--force") or a.startswith("+"):
                        reply("deny", f"опасный git push ({a}) запрещён")
                has_ask = True
                ask_reason = "git push требует подтверждения"

            elif subcmd == "add":
                for a in subargs:
                    if a in ("-f", "--force"):
                        reply("deny", "git add -f запрещён")
                    if a in (".", "-A", "--all"):
                        has_ask = True
                        ask_reason = f"git add {a} требует подтверждения"

            elif subcmd == "reset":
                if "--hard" in subargs:
                    reply("deny", "git reset --hard запрещён")
                has_ask = True
                ask_reason = "git reset требует подтверждения"

            elif subcmd == "clean":
                if any(a.startswith("-f") or a == "--force" for a in subargs):
                    reply("deny", "git clean -f запрещён")

            elif subcmd == "checkout":
                if "-f" in subargs or "--force" in subargs:
                    reply("deny", "git checkout -f запрещён")
                if "." in subargs:
                    has_ask = True
                    ask_reason = "git checkout . требует подтверждения"

            elif subcmd == "restore":
                if "." in subargs:
                    has_ask = True
                    ask_reason = "git restore . требует подтверждения"

            elif subcmd in ("stash", "rebase", "remote"):
                has_ask = True
                ask_reason = f"git {subcmd} требует подтверждения"

def strip_wrappers(tokens):
    idx = 0
    while idx < len(tokens):
        tok = tokens[idx]
        if "=" in tok and not tok.startswith("-"):
            idx += 1
        elif tok in ("env", "command", "nohup", "time", "exec"):
            idx += 1
        else:
            break
    res = tokens[idx:]
    if not res and any(t == "env" for t in tokens):
        reply("deny", "env/printenv запрещён")
    return res

for seg in segments:
    try:
        tokens = shlex.split(seg)
    except Exception:
        tokens = seg.split()

    if not tokens:
        continue

    for t in tokens:
        if not t.startswith("-") and secret_file_pat.search(t):
            reply("deny", f"доступ к секретным файлам ({t}) запрещён")

    cmd_tokens = strip_wrappers(tokens)
    check_segment_tokens(cmd_tokens)

if has_ask:
    reply("ask", ask_reason)
reply("allow", "разрешено")
PY
