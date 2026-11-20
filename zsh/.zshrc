# Показываем fastfetch ТОЛЬКО в интерактивном терминале и ТОЛЬКО если нас не вызвал AI-агент
if [[ $- == *i* ]] && [[ -z "$AI_AGENT_RUNNING" ]] && [[ ! "$(< /proc/$PPID/cmdline 2>/dev/null)" =~ (opencode|agy|aider) ]]; then
    fastfetch -l arch_small
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

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
          --sub-langs "all" \
          --fragment-retries infinite --legacy-server-connect \
          --downloader aria2c \
          --downloader-args "aria2c:--console-log-level=warn --summary-interval=0" \
          -P "$HOME/Videos/Anime" \
          -o "Серия_${current_ep}.%(ext)s" \
          "$url"

        ((current_ep++))
    done

    echo -e "\n==> Готово."
}

alias update='yay'

# Установка черно-белых обоев одной командой (через awww)
alias set-wall='awww img'

# ── Dotfiles (GNU Stow) ──────────────────────────────────────────
export DOTFILES="$HOME/dotfiles"
alias dots='cd "$DOTFILES"'

dpush() {
  git -C "$DOTFILES" add -u || return
  local new
  new=$(git -C "$DOTFILES" ls-files --others --exclude-standard)
  if [[ -n $new ]]; then
    echo "⚠ не добавлены новые файлы (git add <файл>):"
    echo "$new"
  fi
  git -C "$DOTFILES" commit -m "${1:-Update dotfiles $(date +'%F %H:%M')}" \
    && git -C "$DOTFILES" push -u origin main
}

cpull() {
  git -C "$DOTFILES" pull --no-rebase origin main \
    && "$DOTFILES/install.sh" \
    && exec zsh
}

alias phone='adb forward tcp:8022 tcp:8022 && ssh -p 8022 localhost'

recmic() {
    local dir="$HOME/Recordings"
    mkdir -p "$dir"
    local f="$dir/mic_$(date +%F_%H-%M-%S)"

    echo "(o_o) Запись в WAV. Остановка: Ctrl+C"
    trap ':' INT
    pw-record --channels=1 --rate=48000 --format=s16 "$f.wav"
    trap - INT

    if [[ -s "$f.wav" ]]; then
        echo "\n(^-^) Конвертация в Opus..."
        ffmpeg -hide_banner -loglevel error -i "$f.wav" -c:a libopus -b:a 48k -vbr on "$f.opus" && \
            rm -f "$f.wav" && \
            echo "(^_^)b Готово: $f.opus"
    fi
}

recvid() {
    local dir="$HOME/Recordings"
    mkdir -p "$dir"
    local f="$dir/rec_$(date +%F_%H-%M-%S).mp4"
    local args=(-r 60 -C aac -f "$f")
    local m1="" m2="" m3=""

    _recvid_cleanup() {
        local m
        for m in $m3 $m2 $m1; do
            pactl unload-module "$m" >/dev/null 2>&1 || true
        done
    }

    if command -v pactl >/dev/null 2>&1; then
        local def_sink def_mic
        def_sink=$(pactl get-default-sink 2>/dev/null || true)
        if pactl list short sources 2>/dev/null | awk '{print $2}' | grep -qx "source.clean_mic"; then
            def_mic="source.clean_mic"
        else
            def_mic=$(pactl get-default-source 2>/dev/null || true)
        fi
        if [[ -n "$def_sink" && -n "$def_mic" ]]; then
            m1=$(pactl load-module module-null-sink sink_name=rec_mix sink_properties=device.description=RecMix 2>/dev/null || true)
            m2=$(pactl load-module module-loopback source="${def_sink}.monitor" sink=rec_mix 2>/dev/null || true)
            m3=$(pactl load-module module-loopback source="${def_mic}" sink=rec_mix 2>/dev/null || true)
        fi
    fi

    if [[ -n "$m1" && -n "$m2" && -n "$m3" ]]; then
        args+=(--audio="rec_mix.monitor")
    else
        _recvid_cleanup
        m1=""; m2=""; m3=""
        args+=(--audio)
    fi

    if [[ "${1:-}" == "area" ]]; then
        local geom
        geom=$(slurp) || { _recvid_cleanup; return 0; }
        args+=(-g "$geom")
    fi

    if [[ -r /dev/dri/renderD128 ]]; then
        args+=(-c h264_vaapi -d /dev/dri/renderD128 -p qp=23)
    else
        args+=(-c libx264 -p preset=veryfast -p crf=23)
    fi

    echo "(o_o) Запись экрана в MP4 (видео + микрофон + звук системы). Остановка: Ctrl+C"
    trap ':' INT
    wf-recorder "${args[@]}" >/dev/null 2>&1
    trap - INT
    _recvid_cleanup

    if [[ -s "$f" ]]; then
        echo "\n(^_^)b Готово: $f"
    fi
}

# --- AI-агенты ---
[[ -f "$HOME/.zshrc_secrets" ]] && source "$HOME/.zshrc_secrets"

oc-dots()  { (cd "$DOTFILES" && AI_AGENT_RUNNING=1 opencode "$@") }
agy-dots() {
  (
    cd "$DOTFILES" && \
    http_proxy="http://127.0.0.1:10809" \
    https_proxy="http://127.0.0.1:10809" \
    HTTP_PROXY="http://127.0.0.1:10809" \
    HTTPS_PROXY="http://127.0.0.1:10809" \
    AI_AGENT_RUNNING=1 agy "$@"
  )
}

# Added by Antigravity CLI installer
export PATH="$HOME/.local/bin:$PATH"

# Промпт Starship (конфиг — ~/.config/starship.toml)
eval "$(starship init zsh)"
