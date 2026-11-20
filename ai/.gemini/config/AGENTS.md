# Глобальные правила для Antigravity (AGY)

## Язык и стиль
- Общайся по-русски, коротко, без воды.
- Не добавляй фразы вроде «Конечно!», «Отлично!», «Я помогу вам».

## Репозиторий dotfiles
- Правила репозитория dotfiles лежат в `AGENTS.md` в корне `~/dotfiles`.

## Красные линии (запрещено без явной команды)
- `sudo`, `su`, `doas` — любая команда с повышением прав.
- `pacman`, `yay`, `paru` — управление пакетами; `chsh`.
- `rm -rf` и любое рекурсивное удаление вне `~/dotfiles` и `~/dotfiles-backup`.
- `git push --force/-f/--force-with-lease/--tags/--mirror`, push не в целевую ветку, `git add -f`, `git reset --hard`, `git clean -f`, `git checkout -f`.
- `git push` — только после ритуала и явного подтверждения «да».
- Выход из сессии, перезапуск композитора, запуск `hyprlock`.
- `systemctl` без `--user`.
- Секреты: `~/.zshrc_secrets`, `~/.ssh/**`, `~/.gnupg/**`, содержимое `~/.gemini/**` (кроме `ai/.gemini/...`), `*.env`, `*.env.*`, файлы с `secret/key/token/credential/password` в имени; не печатать окружение (`env`, `printenv`, `echo $...KEY`).
