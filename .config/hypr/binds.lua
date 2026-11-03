---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "kitty"
local menu        = "fuzzel"
local fileManager = "nautilus"


---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

-- Основные программы и утилиты
hl.bind(mainMod .. " + N",         hl.dsp.exec_cmd("makoctl restore"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("makoctl dismiss -a"))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())

-- История буфера обмена (cliphist наполняется в AUTOSTART)
hl.bind(mainMod .. " + SHIFT + V",
    hl.dsp.exec_cmd("bash -c 'cliphist list | fuzzel --dmenu | cliphist decode | wl-copy'"))
-- Выход из сессии: подальше от SUPER+E (nautilus), чтобы не промахнуться
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())

-- Блокировка экрана (с переключением раскладки на US).
-- Раньше шло через loginctl lock-session → hypridle.lock_cmd: если
-- hypridle не поднят, loginctl молчит и экран не блокируется.
-- Теперь зовём hyprlock напрямую с pidof-страховкой: работает всегда,
-- второй экземпляр не запускается.
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("sh -c 'hyprctl switchxkblayout current 0 && (pidof hyprlock >/dev/null || hyprlock)'"))

-- Плавающее / плиточное окно (нативный диспетчер Hyprland)
hl.bind(mainMod .. " + V", hl.dsp.window.float())

-- Шпаргалка по хоткеям (работает при любой раскладке US/RU)
hl.bind(mainMod .. " + code:61", hl.dsp.exec_cmd("bash -c '$HOME/.local/bin/keybinds'"))

-- Обои
-- Случайные обои на Mod+A
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("bash -c '$HOME/.local/bin/wall-random'"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("bash -c '$HOME/.local/bin/wall-picker'"))

-- Управление окнами
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + C",         hl.dsp.window.center())
hl.bind(mainMod .. " + R",         hl.dsp.layout("togglesplit"))
-- Pseudo-tile: окно занимает половину тайла (удобно для терминала/браузера)
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo())

-- Фокус окон (стрелки)
hl.bind(mainMod .. " + Left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + Up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Down",  hl.dsp.focus({ direction = "down" }))

-- Перемещение окон (Shift + стрелки)
hl.bind(mainMod .. " + SHIFT + Left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + Up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + Down",  hl.dsp.window.move({ direction = "down" }))

-- Группы окон (как в Niri): объединяем окна в табы.
-- Через hyprctl dispatch: имена group-функций в Lua-API не гарантированы.
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("hyprctl dispatch togglegroup"))
hl.bind(mainMod .. " + ALT + Left",  hl.dsp.exec_cmd("hyprctl dispatch changegroupactive b"))
hl.bind(mainMod .. " + ALT + Right", hl.dsp.exec_cmd("hyprctl dispatch changegroupactive f"))
hl.bind(mainMod .. " + ALT + SHIFT + Left",  hl.dsp.exec_cmd("hyprctl dispatch moveintogroup l"))
hl.bind(mainMod .. " + ALT + SHIFT + Right", hl.dsp.exec_cmd("hyprctl dispatch moveintogroup r"))
hl.bind(mainMod .. " + ALT + SHIFT + Up",    hl.dsp.exec_cmd("hyprctl dispatch moveintogroup u"))
hl.bind(mainMod .. " + ALT + SHIFT + Down",  hl.dsp.exec_cmd("hyprctl dispatch moveintogroup d"))
hl.bind(mainMod .. " + ALT + L",         hl.dsp.exec_cmd("hyprctl dispatch lockgroups lock"))
hl.bind(mainMod .. " + ALT + SHIFT + L", hl.dsp.exec_cmd("hyprctl dispatch lockgroups unlock"))

-- Ресайз с клавиатуры: resizeactive работает и для тайлов, и для floating
hl.bind(mainMod .. " + CTRL + Left",  hl.dsp.exec_cmd("hyprctl dispatch resizeactive -40 0"))
hl.bind(mainMod .. " + CTRL + Right", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 40 0"))
hl.bind(mainMod .. " + CTRL + Up",    hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -40"))
hl.bind(mainMod .. " + CTRL + Down",  hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 40"))

-- Точный пиксельный ресайз для floating-окон (resizewindowpixel)
hl.bind(mainMod .. " + ALT + CTRL + Left",  hl.dsp.exec_cmd("hyprctl dispatch resizewindowpixel -40 0,activewindow"))
hl.bind(mainMod .. " + ALT + CTRL + Right", hl.dsp.exec_cmd("hyprctl dispatch resizewindowpixel 40 0,activewindow"))
hl.bind(mainMod .. " + ALT + CTRL + Up",    hl.dsp.exec_cmd("hyprctl dispatch resizewindowpixel 0 -40,activewindow"))
hl.bind(mainMod .. " + ALT + CTRL + Down",  hl.dsp.exec_cmd("hyprctl dispatch resizewindowpixel 0 40,activewindow"))

-- Перестановка окон (swapwindow) вместо перемещения
hl.bind(mainMod .. " + CTRL + SHIFT + Left",  hl.dsp.exec_cmd("hyprctl dispatch swapwindow l"))
hl.bind(mainMod .. " + CTRL + SHIFT + Right", hl.dsp.exec_cmd("hyprctl dispatch swapwindow r"))
hl.bind(mainMod .. " + CTRL + SHIFT + Up",    hl.dsp.exec_cmd("hyprctl dispatch swapwindow u"))
hl.bind(mainMod .. " + CTRL + SHIFT + Down",  hl.dsp.exec_cmd("hyprctl dispatch swapwindow d"))

-- Рабочие столы 1-9
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i,     hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad: выпадающий слоем поверх текущего воркспейса
hl.bind(mainMod .. " + S",         hl.dsp.exec_cmd("hyprctl dispatch togglespecialworkspace scratchpad"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprctl dispatch movetoworkspacesilent special:scratchpad"))

-- Перемещение между соседними воркспейсами по вертикали (как в Niri Mod+Up/Down)
hl.bind(mainMod .. " + Page_Up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + Page_Down", hl.dsp.focus({ workspace = "e+1" }))

-- Переключение рабочих столов колесом мыши (SUPER + scroll).
-- Само событие поглощается благодаря binds:pass_mouse_when_bound = false
-- (см. блок MOUSE EVENT CONSUMPTION выше).
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), { mouse = true })
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { mouse = true })

-- Мышь: перемещение и изменение размера окон
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Мультимедиа (Громкость)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),   { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),   { locked = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),  { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

-- Мультимедиа (плеер)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Перезагрузка конфига без выхода из сессии. Hyprland обычно сам
-- подхватывает правки, бинд — на случай, когда не подхватил.
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Прокси: переключение on/off (env Hyprland + GSettings + systemd --user).
-- Состояние запоминается в ~/.local/state/proxy и восстанавливается при входе.
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("bash -c '$HOME/.local/bin/proxy toggle'"))

---------------------
---- SCREENSHOTS ----
---------------------
local home = os.getenv("HOME")
local ss_cmd = home .. "/.local/bin/screenshot"

-- Область (Ctrl + Shift + S, работает при любой раскладке US/RU)
hl.bind("CTRL + SHIFT + code:39", hl.dsp.exec_cmd(ss_cmd .. " area"))

-- Полный экран (Ctrl + Print)
hl.bind("CTRL + Print", hl.dsp.exec_cmd(ss_cmd .. " full"))

-- Активное окно (Alt + Print)
hl.bind("ALT + Print",  hl.dsp.exec_cmd(ss_cmd .. " window"))
