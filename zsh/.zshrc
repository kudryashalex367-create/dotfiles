# Показываем fastfetch ТОЛЬКО в интерактивном терминале и ТОЛЬКО если нас не вызвал AI-агент
if [[ $- == *i* ]] && [[ -z "$AI_AGENT_RUNNING" ]] && [[ ! "$(< /proc/$PPID/cmdline 2>/dev/null)" =~ (opencode|agy|aider) ]]; then
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
alias matrix='cmatrix -b -C magenta -u 3'
alias lava='lavat -c magenta -s 2 -R 1'
alias zen='cbonsai -l -i -w 3 -m "zev1ce"'
alias clock='tty-clock -s -c -b -C 5'

# ── Dotfiles (GNU Stow) ──────────────────────────────────────────
export DOTFILES="$HOME/dotfiles"
alias config='git -C "$DOTFILES"'

dpush() {
  git -C "$DOTFILES" add -u || return
  local new
  new=$(git -C "$DOTFILES" ls-files --others --exclude-standard)
  if [[ -n $new ]]; then
    echo "⚠ не добавлены новые файлы (config add -- <файл>):"
    echo "$new"
  fi
  git -C "$DOTFILES" commit -m "${1:-Update dotfiles $(date +'%F %H:%M')}" \
    && git -C "$DOTFILES" push -u origin main
}
alias cpush=dpush

cpull() {
  git -C "$DOTFILES" pull --no-rebase origin main \
    && "$DOTFILES/install.sh" \
    && exec zsh
}

alias phone='adb forward tcp:8022 tcp:8022 && ssh -p 8022 localhost'

# --- AI-агенты ---
# Ключ AITUNNEL_API_KEY (не OPENAI_API_KEY, чтобы встроенный провайдер не подхватывал)
[[ -f "$HOME/.zshrc_secrets" ]] && source "$HOME/.zshrc_secrets"

oc-dots()  { (cd "$DOTFILES" && AI_AGENT_RUNNING=1 opencode "$@") }
agy-dots() { (cd "$DOTFILES" && AI_AGENT_RUNNING=1 agy "$@") }
