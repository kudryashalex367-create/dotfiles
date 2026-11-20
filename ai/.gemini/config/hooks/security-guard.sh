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
    cmd = data.get("toolCall", {}).get("args", {}).get("CommandLine", "")
except Exception as e:
    reply("ask", f"hook error: {e}")

if not cmd or not cmd.strip():
    reply("allow", "empty command")

cmd = cmd.strip()

# 1. Check secrets in raw command string
# .zshrc_secrets, /.ssh, /.gnupg
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
segments = []
current = []
in_single = False
in_double = False
i = 0
while i < len(cmd):
    c = cmd[i]
    if c == "'" and not in_double:
        in_single = not in_single
        current.append(c)
        i += 1
    elif c == '"' and not in_single:
        in_double = not in_double
        current.append(c)
        i += 1
    elif not in_single and not in_double:
        m = re.match(pattern, cmd[i:])
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

secret_file_pat = re.compile(r'(^|[\s/])([a-zA-Z0-9_-]*(secret|password|credential)[a-zA-Z0-9_-]*\.[a-zA-Z0-9]+)(\b|[\s"\']|$)', re.I)

has_ask = False
ask_reason = ""

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

    # Strip env assignments and command wrappers
    idx = 0
    while idx < len(tokens):
        tok = tokens[idx]
        if "=" in tok and not tok.startswith("-"):
            idx += 1
        elif tok in ("env", "command", "nohup", "time", "exec"):
            idx += 1
        else:
            break

    cmd_tokens = tokens[idx:]
    if not cmd_tokens:
        if any(t == "env" for t in tokens):
            reply("deny", "env/printenv запрещён")
        continue

    base_bin = os.path.basename(cmd_tokens[0])

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

if has_ask:
    reply("ask", ask_reason)
reply("allow", "разрешено")
PY
