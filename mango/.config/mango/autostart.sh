#!/usr/bin/env bash
# Автозапуск Mango: вызывается из config.conf (exec_once).
# Здесь только то, что в Hyprland лежало в autostart.lua.
set -u

# Утилиты и демоны
mako >/dev/null 2>&1 &
pidof hypridle >/dev/null || hypridle >/dev/null 2>&1 &
awww-daemon >/dev/null 2>&1 &

# Палитра от последних обоев (matugen) + reload композитора
"$HOME/.local/bin/wall-restore" >/dev/null 2>&1 &

# Импорт переменных окружения для порталов и PipeWire
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=mango 2>/dev/null || true

# Портал для скриншотов и трансляции экрана (ScreenCast/PipeWire)
/usr/lib/xdg-desktop-portal-wlr >/dev/null 2>&1 &

# Порталы, буфер обмена, секреты
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 >/dev/null 2>&1 &
wl-paste --watch cliphist store >/dev/null 2>&1 &
gnome-keyring-daemon --start --components=secrets >/dev/null 2>&1 &

# Прокси: сохранённое состояние (env + GSettings + environment.d)
"$HOME/.local/bin/proxy" restore >/dev/null 2>&1 &

# Курсор
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice' 2>/dev/null || true
gsettings set org.gnome.desktop.interface cursor-size 24 2>/dev/null || true
