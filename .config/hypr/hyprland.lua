------------------
---- MONITORS ----
------------------
-- Мониторы с герцовкой 144Hz
hl.monitor({
    output   = "DP-2",
    mode     = "1920x1080@144.00",
    position = "auto",
    scale    = "1",
})
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@144.00",
    position = "auto",
    scale    = "1",
})
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@144.00",
    position = "auto",
    scale    = "1",
})


---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "kitty"
local menu        = "fuzzel"
local fileManager = "nautilus"


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
-- Курсор
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")

-- Прокси
hl.env("http_proxy", "http://127.0.0.1:12334")
hl.env("https_proxy", "http://127.0.0.1:12334")
hl.env("all_proxy", "socks5://127.0.0.1:12334")
hl.env("HTTP_PROXY", "http://127.0.0.1:12334")
hl.env("HTTPS_PROXY", "http://127.0.0.1:12334")
hl.env("ALL_PROXY", "socks5://127.0.0.1:12334")


-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function ()
    -- Утилиты и демоны
    hl.exec_cmd("swaync")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")

    -- Настройки прокси через GSettings
    hl.exec_cmd("gsettings set org.gnome.system.proxy mode 'manual'")
    hl.exec_cmd("gsettings set org.gnome.system.proxy.http host '127.0.0.1'")
    hl.exec_cmd("gsettings set org.gnome.system.proxy.http port 12334")
    hl.exec_cmd("gsettings set org.gnome.system.proxy.https host '127.0.0.1'")
    hl.exec_cmd("gsettings set org.gnome.system.proxy.https port 12334")
    hl.exec_cmd("gsettings set org.gnome.system.proxy.socks host '127.0.0.1'")
    hl.exec_cmd("gsettings set org.gnome.system.proxy.socks port 12334")

    -- Настройки курсора
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 24")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
end)


---------------
---- INPUT ----
---------------
hl.config({
    input = {
        -- Раскладка и переключение по Win+Space
        kb_layout  = "us,ru",
        kb_options = "grp:win_space_toggle",

        follow_mouse = 1,
        sensitivity  = -0.4, -- Скорость мыши (как mouse: accel-speed -0.4)

        touchpad = {
            tap_to_click   = true,
            natural_scroll = true,
        },
    },
})

-- Жесты тачпада
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})


-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 2,

        col = {
            active_border   = "rgba(ffffffff)",
            inactive_border = "rgba(27272aff)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 16,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        blur = {
            enabled           = true,
            size              = 6,
            passes            = 3,
            noise             = 0.015,
            contrast          = 1.05,
            brightness        = 0.95,
            vibrancy          = 0.25,
            vibrancy_darkness = 0.15,
            popups            = true,
            ignore_opacity    = true,
            new_optimizations = true,
        },
    },

    animations = {
        enabled = true,
    },
})

--------------------
---- ANIMATIONS ----
--------------------
-- 1. Сверхплавная пружина как в Niri (damping-ratio ~1.05: НОЛЬ отскоков и вибраций)
-- Для stiffness = 500 критическое затухание ~45-48
hl.curve("smoothSpring", {
    type      = "spring",
    mass      = 1,
    stiffness = 420,
    dampening = 46,
})

-- 2. Мягкие кинематографичные кривые Безье для открытия/закрытия и фейдов
hl.curve("niriEaseOut", { type = "bezier", points = { {0.16, 1},   {0.3, 1} } })
hl.curve("smoothFade",  { type = "bezier", points = { {0.25, 0.1}, {0.25, 1} } })

-- Глобальная кривая
hl.animation({ leaf = "global", enabled = true, speed = 4.0, bezier = "niriEaseOut" })

-- Перемещение и ресайз окон (плавное физическое скольжение без дребезга)
hl.animation({ leaf = "windows",     enabled = true, speed = 5.0, spring = "smoothSpring" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5.0, spring = "smoothSpring" })

-- Открытие и закрытие окон (аккуратный быстрый fade + мягкий зум, без резкого вылета)
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 3.2, bezier = "niriEaseOut", style = "popin 92%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.4, bezier = "niriEaseOut", style = "popin 94%" })

-- Плавное переключение рабочих столов (скольжение без тряски)
hl.animation({ leaf = "workspaces",   enabled = true, speed = 4.8, spring = "smoothSpring", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 4.8, spring = "smoothSpring", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 4.8, spring = "smoothSpring", style = "slide" })

-- Слои (меню Fuzzel, SwayNC) и затухания
hl.animation({ leaf = "fade",       enabled = true, speed = 3.0, bezier = "smoothFade" })
hl.animation({ leaf = "layers",     enabled = true, speed = 3.5, bezier = "niriEaseOut" })
hl.animation({ leaf = "layersIn",   enabled = true, speed = 3.0, bezier = "niriEaseOut", style = "fade" })
hl.animation({ leaf = "layersOut",  enabled = true, speed = 2.0, bezier = "smoothFade",  style = "fade" })
hl.animation({ leaf = "border",     enabled = true, speed = 4.0, bezier = "smoothFade" })

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

-- Основные программы и утилиты
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())

-- Блокировка экрана (с переключением на английский)
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("sh -c 'hyprctl switchxkblayout current 0 && hyprlock'"))

-- Буфер обмена (fuzzel + cliphist)
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("bash -c 'cliphist list | fuzzel -d | cliphist decode | wl-copy'"))

-- SwayNC панель с обновлением даты
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("sh -c 'CUR_TIME=$(date +\"%H:%M  ·  %A, %d %b\") && sed -i \"s/\\\"text\\\": \\\".*\\\"/\\\"text\\\": \\\"$CUR_TIME\\\"/\" ~/.config/swaync/config.json && swaync-client -R && swaync-client -t -sw'"))

-- Обои
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("bash -c '$HOME/.local/bin/wall-picker'"))

-- Управление окнами
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + C",         hl.dsp.window.center())
hl.bind(mainMod .. " + R",         hl.dsp.layout("togglesplit"))

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

-- Рабочие столы 1-5
for i = 1, 5 do
    hl.bind(mainMod .. " + " .. i,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i,     hl.dsp.window.move({ workspace = i }))
end

-- Перемещение между соседними воркспейсами по вертикали (как в Niri Mod+Up/Down)
hl.bind(mainMod .. " + Page_Up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + Page_Down", hl.dsp.focus({ workspace = "e+1" }))

-- Мышь: перемещение и изменение размера окон
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Мультимедиа (Громкость)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),   { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),   { locked = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),  { locked = true })

---------------------
---- SCREENSHOTS ----
---------------------
local home = os.getenv("HOME")
local ss_cmd = home .. "/.local/bin/screenshot"

-- Область (Ctrl + Shift + S, работает при любой раскладке US/RU)
hl.bind("CTRL + SHIFT + S", hl.dsp.exec_cmd(ss_cmd .. " area"))
hl.bind("CTRL + SHIFT + code:39", hl.dsp.exec_cmd(ss_cmd .. " area"))

-- Полный экран (Ctrl + Print)
hl.bind("CTRL + Print", hl.dsp.exec_cmd(ss_cmd .. " full"))

-- Активное окно (Alt + Print)
hl.bind("ALT + Print",  hl.dsp.exec_cmd(ss_cmd .. " window"))

--------------------------------
---- WINDOWS AND LAYER RULES ---
--------------------------------
-- Окно списка друзей Steam открывается в Floating режиме
hl.window_rule({
    name  = "steam-friends-float",
    match = {
        class = "^(steam)$",
        title = "^(Friends List.*)$",
    },
    float = true,
})

-- Эффект размытия для лончера Fuzzel / Launcher
hl.layer_rule({
    name  = "blur-launcher",
    match = {
        namespace = "^(launcher|fuzzel)$",
    },
    blur = true,
})
