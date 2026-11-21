#!/usr/bin/env bash
# Тестирование security-guard хука
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
HOOK="${1:-$SCRIPT_DIR/../security-guard.sh}"

echo "Тестируем хук: $HOOK"

declare -a CASES=(
    "deny|sudo reboot"
    "deny|ls && sudo reboot"
    "deny|echo hi | sudo tee /x"
    "deny|/usr/bin/sudo -v"
    "deny|pacman -S foo"
    "deny|yay -S foo"
    "deny|paru -S foo"
    "deny|rm -rf ~/Documents"
    "deny|rm -fr /tmp/x"
    "deny|rm -r -f /x"
    "deny|rm --recursive --force /x"
    "allow|rm -rf ~/dotfiles/tmp-dir"
    "allow|rm -rf tmp-dir"
    "allow|ls 2>&1"
    "deny|git push --force"
    "deny|git push -f origin main"
    "deny|git push origin +main"
    "ask|git push origin main"
    "ask|git -C ~/dotfiles push origin main"
    "ask|git add ."
    "ask|git add -A"
    "deny|git add -f x"
    "deny|git reset --hard"
    "deny|git clean -fd"
    "allow|git add -- bin/.local/bin/hub"
    "allow|git add -u"
    "allow|git commit -m \"x\""
    "deny|cat ~/.zshrc_secrets"
    "deny|ls ~/.ssh"
    "deny|cat ~/.gnupg/x"
    "deny|cat .env"
    "allow|cat ~/dotfiles/ai/.gemini/config/AGENTS.md"
    "deny|systemctl restart foo"
    "deny|printenv"
    "allow|systemctl --user status audio-combine.service"
    "allow|git status -sb"
    "allow|git diff HEAD --stat"
    "allow|bash -n bin/.local/bin/hub"
    "allow|stow -n -v --no-folding -t \"\$HOME\" -R systemd"
    "allow|./install.sh bin systemd ai hypr"
    "allow|chmod +x bin/.local/bin/dpms"
    "allow|grep -n foo file"
    "allow|sed -n '1,20p' file"
    "deny|python3 -c \"import os; os.system('sudo reboot')\""
    "deny|python3 -c \"import base64; exec(base64.b64decode('x'))\""
    "deny|python3 -c \"open('/home/zev1ce/.ssh/id_rsa')\""
    "deny|echo c3Vkbw== | base64 -d | bash"
    "deny|bash -c \"sudo reboot\""
    "deny|sh -c \"cat ~/.zshrc_secrets\""
    "deny|eval \"sudo reboot\""
    "allow|python3 -c 'import sys, json; print(1)'"
)

# Дополнительные тесты для MCP и других инструментов
declare -a TOOL_CASES=(
    "ask|call_mcp_tool|{\"ServerName\": \"git\", \"ToolName\": \"git_commit\"}"
    "allow|call_mcp_tool|{\"ServerName\": \"git\", \"ToolName\": \"git_status\"}"
    "ask|call_mcp_tool|{\"ServerName\": \"fetch\", \"ToolName\": \"fetch\"}"
    "allow|call_mcp_tool|{\"ServerName\": \"horizon\", \"ToolName\": \"instance_list\"}"
    "deny|read_file|{\"Path\": \"/home/zev1ce/.ssh/id_rsa\"}"
    "deny|read_file|{\"Path\": \"/home/zev1ce/.zshrc_secrets\"}"
    "allow|read_file|{\"Path\": \"/home/zev1ce/dotfiles/AGENTS.md\"}"
    "deny|write_file|{\"Path\": \"/home/zev1ce/.bashrc\"}"
    "allow|write_file|{\"Path\": \"/home/zev1ce/dotfiles/README.md\"}"
)

passed=0
failed=0

for c in "${CASES[@]}"; do
    expected="${c%%|*}"
    cmd="${c#*|}"

    json_payload=$(python3 -c 'import sys, json; print(json.dumps({"toolCall": {"name": "run_command", "args": {"CommandLine": sys.argv[1]}}}))' "$cmd")
    result=$(printf '%s' "$json_payload" | bash "$HOOK")
    decision=$(python3 -c 'import sys, json; print(json.loads(sys.argv[1]).get("decision", "error"))' "$result" 2>/dev/null || echo "parse_error")

    if [[ "$decision" == "$expected" ]]; then
        passed=$(( passed + 1 ))
    else
        echo "FAIL: '$cmd' -> ожидали '$expected', получили '$decision' (вывод: $result)"
        failed=$(( failed + 1 ))
    fi
done

for tc in "${TOOL_CASES[@]}"; do
    IFS='|' read -r expected tname targs <<< "$tc"
    json_payload=$(python3 -c 'import sys, json; print(json.dumps({"toolCall": {"name": sys.argv[1], "args": json.loads(sys.argv[2])}}))' "$tname" "$targs")
    result=$(printf '%s' "$json_payload" | bash "$HOOK")
    decision=$(python3 -c 'import sys, json; print(json.loads(sys.argv[1]).get("decision", "error"))' "$result" 2>/dev/null || echo "parse_error")

    if [[ "$decision" == "$expected" ]]; then
        passed=$(( passed + 1 ))
    else
        echo "FAIL TOOL: '$tname $targs' -> ожидали '$expected', получили '$decision' (вывод: $result)"
        failed=$(( failed + 1 ))
    fi
done

total=$(( ${#CASES[@]} + ${#TOOL_CASES[@]} ))
echo "Результат: $passed/$total пройдено (ошибок: $failed)"
if (( failed > 0 )); then
    exit 1
fi
