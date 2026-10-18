if [[ $- == *i* ]]; then
    fastfetch -l arch_small
fi

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Path
export PATH="$PATH:$HOME/.local/bin"

# ── Useful Aliases ───────────────────────────────────────────────
# Скачивание видео через yt-dlp
alias y='yt-dlp -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]/best" --merge-output-format mp4 -o "%(title)s.%(ext)s"'

# Скачивание аудио (SponsorBlock вырезает рекламу/интро/аутро)
ya() {
    yt-dlp \
        -f 'ba[ext=opus]/ba[ext=m4a]/ba' \
        --sponsorblock-remove sponsor,selfpromo,interaction,intro,outro,music_offtopic \
        --embed-thumbnail \
        --add-metadata \
        --continue \
        --no-overwrites \
        --ignore-errors \
        -P "$HOME/Music" \
        -o "%(title)s.%(ext)s" \
        "$@"
}

# Аниме по сериям: nya [номер_первой_серии] url1 url2 ...
nya() {
    local current_ep=1
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        current_ep="$1"
        shift
    fi

    for url in "$@"; do
        echo -e "\n==> Скачивание серии $current_ep..."

        yt-dlp -f "bv*+ba/best" \
          --merge-output-format mkv \
          --embed-subs --embed-thumbnail --embed-chapters --add-metadata \
          --sub-langs "ru.*,en.*,all" \
          --fragment-retries infinite --concurrent-fragments 5 --legacy-server-connect \
          --downloader aria2c \
          --downloader-args "aria2c:--console-log-level=warn --summary-interval=0" \
          -P "$HOME/Videos/Anime" \
          -o "Серия_${current_ep}.%(ext)s" \
          "$url"

        ((current_ep++))
    done

    echo -e "\n==> Готово."
}

alias update='yay -Syu'

# Установка черно-белых обоев одной командой (через awww)
alias set-wall='awww img'

# ── Aesthetic Desk Launchers ─────────────────────────────────────
alias matrix='cmatrix -b -C white -u 3'
alias lava='lavat -c white -s 2 -R 1'
alias zen='cbonsai -l -i -w 3 -m "zev1ce"'
alias clock='tty-clock -s -c -b -C 7'

# ── Git Bare Dotfiles Manager ────────────────────────────────────
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

cpush() {
  config add -u
  local msg="${1:-Update dotfiles $(date +'%Y-%m-%d %H:%M')}"
  config commit -m "$msg" && config push -u origin main
}

cpull() {
  config pull origin main --no-rebase && exec zsh
}

alias phone='adb forward tcp:8022 tcp:8022 && ssh -p 8022 localhost'

# --- Aider Configuration ---
# 1. Безопасная загрузка приватных ключей (если файл существует)
if [[ -f "$HOME/.zshrc_secrets" ]]; then
    source "$HOME/.zshrc_secrets"
fi

aider-dotfiles() {
    if [[ -z "$OPENAI_API_KEY" ]]; then
        echo "Ошибка: OPENAI_API_KEY не найден. Проверь ~/.zshrc_secrets"
        return 1
    fi

    mkdir -p "$HOME/.cache/aider"

    (
        cd "$HOME" || exit 1
        aider --no-git \
              --chat-mode ask \
              --model openai/deepseek-v4.1-flash \
              --edit-format diff \
              --openai-api-base https://api.aitunnel.ru/v1 \
              --no-show-model-warnings \
              --chat-history-file "$HOME/.cache/aider/chat.md" \
              --input-history-file "$HOME/.cache/aider/input" \
              "$@"
    )
}
