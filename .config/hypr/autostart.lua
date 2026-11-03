-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function ()
    -- Утилиты и демоны
    hl.exec_cmd("mako")
    -- Автоблокировка: DPMS + hyprlock (см. hypridle.conf).
    -- pidof-страховка: при повторном hyprland.start второй демон не нужен.
    hl.exec_cmd("bash -c 'pidof hypridle >/dev/null || hypridle'")
    hl.exec_cmd("awww-daemon")
    -- Восстанавливаем палитру от последних обоев: hyprctl keyword не переживает перезапуск.
    hl.exec_cmd("bash -c '$HOME/.local/bin/wall-restore'")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")

    -- Прокси: применяем сохранённое состояние (env + GSettings + environment.d).
    -- Всё внутри скрипта, в конфиге прокси больше нигде не дублируется.
    hl.exec_cmd("bash -c '$HOME/.local/bin/proxy restore'")

    -- Настройки курсора
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 24")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")

end)
