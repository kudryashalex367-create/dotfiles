-------------------
---- WALL COLORS ---
-------------------
-- Палитра из обоев: генерируется matugen в ~/.config/hypr/colors.lua.
-- Fallback — фиолетовая схема, если файла нет или он битый.
local _colors_ok, colors = pcall(dofile, (os.getenv("HOME") or "") .. "/.config/hypr/colors.lua")
if not _colors_ok or type(colors) ~= "table" then
    colors = {
        active_border   = "rgba(a78bfaff)",
        inactive_border = "rgba(2a2140ff)",
        shadow_color    = "rgba(15111fcc)",
    }
end

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
hl.env("http_proxy", "http://127.0.0.1:10809")
hl.env("https_proxy", "http://127.0.0.1:10809")
hl.env("all_proxy", "socks5://127.0.0.1:10808")
hl.env("HTTP_PROXY", "http://127.0.0.1:10809")
hl.env("HTTPS_PROXY", "http://127.0.0.1:10809")
hl.env("ALL_PROXY", "socks5://127.0.0.1:10808")
hl.env("no_proxy", "localhost,127.0.0.1,::1,192.168.0.0/16")
hl.env("NO_PROXY", "localhost,127.0.0.1,::1,192.168.0.0/16")


-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function ()
    -- Утилиты и демоны
    hl.exec_cmd("mako")
    hl.exec_cmd("awww-daemon")
    -- Восстанавливаем палитру от последних обоев: hyprctl keyword не переживает перезапуск.
    hl.exec_cmd("bash -c '$HOME/.local/bin/wall-restore'")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")

    -- Настройки прокси через GSettings
    hl.exec_cmd("gsettings set org.gnome.system.proxy mode 'manual'")
    hl.exec_cmd("gsettings set org.gnome.system.proxy.http host '127.0.0.1'")
    hl.exec_cmd("gsettings set org.gnome.system.proxy.http port 10809")
    hl.exec_cmd("gsettings set org.gnome.system.proxy.https host '127.0.0.1'")
    hl.exec_cmd("gsettings set org.gnome.system.proxy.https port 10809")
    hl.exec_cmd("gsettings set org.gnome.system.proxy.socks host '127.0.0.1'")
    hl.exec_cmd("gsettings set org.gnome.system.proxy.socks port 10808")

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

    -- Курсор не мешает при наборе текста (аналог hide-when-typing в niri)
    cursor = {
        hide_on_key_press = true,
    },
})

-- VFR в новых версиях Hyprland управляется автоматически:
-- опция misc:vfr удалена, задавать её больше не нужно.
hl.config({
    misc = {
        disable_hyprland_logo        = true,
        disable_splash_rendering     = true,
        animate_manual_resizes       = false,
        animate_mouse_windowdragging = false,
    },
})


-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 2,

        -- Рамка активного окна: цвет берётся из палитры обоев (colors.lua)
        col = {
            active_border   = colors.active_border,
            inactive_border = colors.inactive_border,
        },

        -- Ресайз за границу окна + расширенная зона захвата для удобства мышью
        resize_on_border        = true,
        extend_border_grab_area = 15,

        allow_tearing = true, -- Главный переключатель; рвёт только окна с immediate (см. правило games-tearing)
        layout        = "dwindle",
    },

    decoration = {
        rounding       = 16,
        rounding_power = 2,

        active_opacity = 1.0,
        -- Середина между чистой альфой и сильным затемнением: чуть
        -- прозрачности + чуть dim, чтобы фокус читался без «вуали».
        inactive_opacity = 0.975,

        -- Умеренное затемнение неактивных окон — заметно, но не грязно
        dim_inactive = true,
        dim_strength = 0.055,
        dim_special  = 0.2,

        -- Мягкая тень под окнами (range/power снижены — дешевле для композитора)
        shadow = {
            enabled      = true,
            range        = 12,
            render_power = 2,
            color        = colors.shadow_color,
        },

        -- Blur включён глобально. Hyprland сам НЕ размывает фон под
        -- непрозрачными окнами, поэтому блюр реально виден только у
        -- слоёв (fuzzel/mako). ignore_opacity = false — не тратим GPU
        -- на размытие под полностью непрозрачными окнами.
        --
        -- Настройка «богатого» размытия:
        --   size   — радиус блюра (главный фактор глубины);
        --   passes — число проходов (сглаживает, убирает «квадраты»).
        -- Стоимость ≈ size * passes, но new_optimizations снижает её
        -- в разы. 10/3 — мягкое, но недорогое размытие; для «стекла»
        -- можно пробовать 12-14 с passes = 3-4 на мощной GPU.
        blur = {
            enabled           = true,
            size              = 10,
            passes            = 3,
            noise             = 0.02,
            contrast          = 1.1,
            brightness        = 1.0,
            vibrancy          = 0.3,
            vibrancy_darkness = 0.2,
            popups            = true,
            ignore_opacity    = false,
            new_optimizations = true,
            -- xray = true размывает фон «сквозь» все слои (как матовое
            -- стекло на обоях), а не только окно под слоем. Дешевле и
            -- ровнее, но слой перестаёт «учитывать» окна под собой.
            -- xray = true,
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

-- 3. Лёгкий overshoot для «живого» открытия окон
hl.curve("popIn", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

-- Глобальная кривая
hl.animation({ leaf = "global", enabled = true, speed = 4.0, bezier = "niriEaseOut" })

-- Перемещение и ресайз окон (плавное физическое скольжение без дребезга)
hl.animation({ leaf = "windows",     enabled = true, speed = 5.0, spring = "smoothSpring" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5.0, spring = "smoothSpring" })

-- Открытие и закрытие окон (аккуратный быстрый fade + мягкий зум, без резкого вылета)
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 3.2, bezier = "popIn",       style = "popin 90%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.4, bezier = "niriEaseOut", style = "popin 94%" })

-- Плавное переключение рабочих столов (скольжение без тряски)
hl.animation({ leaf = "workspaces",   enabled = true, speed = 4.8, spring = "smoothSpring", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 4.8, spring = "smoothSpring", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 4.8, spring = "smoothSpring", style = "slide" })

-- Special workspace (scratchpad) — плавное появление/скрытие
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4.0, spring = "smoothSpring", style = "slidefade" })

-- Слои (меню Fuzzel) и затухания
hl.animation({ leaf = "fade",       enabled = true, speed = 3.0, bezier = "smoothFade" })
hl.animation({ leaf = "layers",     enabled = true, speed = 3.5, bezier = "niriEaseOut" })
hl.animation({ leaf = "layersIn",   enabled = true, speed = 3.0, bezier = "popIn",       style = "popin 95%" })
hl.animation({ leaf = "layersOut",  enabled = true, speed = 2.0, bezier = "smoothFade",  style = "fade" })
hl.animation({ leaf = "border",     enabled = true, speed = 4.0, bezier = "smoothFade" })

--------------------------------
---- MOUSE EVENT CONSUMPTION ----
--------------------------------
-- Бинды на колесо (SUPER + scroll) не должны доходить до приложения:
-- без этого терминал одновременно листает историю при смене воркспейса.
-- pass_mouse_when_bound гасит только кнопки мыши; для колеса (axis events)
-- отдельный ключ scroll_event_delay — без него событие успевает утечь
-- в окно до того, как сработает бинд.
hl.config({
    binds = {
        pass_mouse_when_bound = false,
        scroll_event_delay    = 0,
    },
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

-- Основные программы и утилиты
hl.bind(mainMod .. " + N",         hl.dsp.exec_cmd("makoctl restore"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("makoctl dismiss -a"))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())

-- Блокировка экрана (с переключением на английский)
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("sh -c 'hyprctl switchxkblayout current 0 && hyprlock'"))

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

-- Рабочие столы 1-9
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i,     hl.dsp.window.move({ workspace = i }))
end

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

-- Игры: tearing только для игровых окон (главный переключатель allow_tearing = true, без immediate ничего не рвётся)
hl.window_rule({
    name  = "games-tearing",
    match = {
        class = "^(cs2|steam_app_.*|horizon)$",
    },
    immediate = true,
})

-- Страховка: kitty всегда открывается в обычном режиме, не fullscreen
hl.window_rule({
    name  = "kitty-no-fullscreen",
    match = {
        class = "^(kitty)$",
    },
    fullscreen = false,
})

-- Эффект размытия для лончера Fuzzel / Launcher
hl.layer_rule({
    name  = "blur-launcher",
    match = {
        namespace = "^(launcher|fuzzel)$",
    },
    blur         = true,
    ignore_alpha = 0.5,
})

-- Эффект размытия для уведомлений Mako (настоящий неймспейс: notifications)
hl.layer_rule({
    name         = "blur-notifications",
    match        = {
        namespace = "^(notifications)$",
    },
    blur         = true,
    ignore_alpha = 0.5,
})
