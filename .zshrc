if [[ $- == *i* ]]; then
    fastfetch
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

# ── Useful Aliases ───────────────────────────────────────────────
# Скачивание видео/аудио через yt-dlp
alias y='yt-dlp -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]/best" --merge-output-format mp4'
alias ya='yt-dlp -x --audio-format mp3 --audio-quality 0'

# Установка черно-белых обоев одной командой (через awww)
alias set-wall='awww img'

# Git Bare Dotfiles Manager
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Local Bin & Pipx
export PATH="$PATH:$HOME/.local/bin"

# ── Aider + Gemini Setup ─────────────────────────────────────────
export GEMINI_API_KEY=""
alias aider-proxy='HTTP_PROXY=http://127.0.0.1:12334 HTTPS_PROXY=http://127.0.0.1:12334 ALL_PROXY=socks5://127.0.0.1:12334 aider --model gemini/gemini-3.1-flash-lite'
alias aider-smart='HTTP_PROXY=http://127.0.0.1:12334 HTTPS_PROXY=http://127.0.0.1:12334 ALL_PROXY=socks5://127.0.0.1:12334 aider --model gemini/gemini-3-flash-preview'

# System fetch on interactive shell start
