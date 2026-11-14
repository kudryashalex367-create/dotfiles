#!/usr/bin/env bash
# AGY security guard hook — блокирует опасные команды
# Читает JSON из stdin, пишет решение в stdout

input=$(cat)
cmd=$(echo "$input" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('toolCall',{}).get('args',{}).get('CommandLine',''))" 2>/dev/null)

deny() {
  echo "{\"decision\":\"deny\",\"reason\":\"$1\"}"
  exit 0
}

ask() {
  echo "{\"decision\":\"ask\",\"reason\":\"$1\"}"
  exit 0
}

# Блокировки без вопросов
echo "$cmd" | grep -qE '^\s*sudo\b'                          && deny "sudo запрещён"
echo "$cmd" | grep -qE '^\s*(pacman|yay|paru)\b'            && deny "управление пакетами запрещено"
echo "$cmd" | grep -qE '\brm\s+-[a-z]*r[a-z]*f\b'          && deny "rm -rf запрещён"
echo "$cmd" | grep -qE '\bchsh\b'                            && deny "chsh запрещён"
echo "$cmd" | grep -qP '(zshrc_secrets|\.ssh/|\.gnupg/)' && deny "доступ к секретам запрещён"
echo "$cmd" | grep -qE '\bgit\s+(push\s+--force|add\s+-A|add\s+\.|add\s+-f|reset\s+--hard|clean\s+-f|stash\b|rebase\b)\b' && deny "опасная git-команда запрещена"

# Запрос подтверждения для умеренно опасных
echo "$cmd" | grep -qE '\bgit\s+push\b'                     && ask "git push требует подтверждения"
echo "$cmd" | grep -qE '\bsystemctl\s+(start|stop|restart|enable|disable|mask)\b' && ask "изменение systemd-сервисов требует подтверждения"

echo '{"decision":"allow"}'
