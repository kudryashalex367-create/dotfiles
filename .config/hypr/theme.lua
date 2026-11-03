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
        -- «Комки» и блочность — это большой size при малом passes:
        -- Hyprland даунскейлит фон сильнее, чем успевает сгладить.
        -- Рабочее соотношение — size 6-8 при passes 4.
        -- noise убран: зерно на слоях читается как грязь, а не стекло.
        blur = {
            enabled           = true,
            size              = 7,
            passes            = 4,
            contrast          = 1.0,
            brightness        = 1.0,
            vibrancy          = 0.15,
            vibrancy_darkness = 0.1,
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

hl.config({
    dwindle = {
        -- Направление сплита сохраняется, новые окна делят самую большую область,
        -- а не «приклеиваются» справа-снизу.
        preserve_split       = true,
        smart_split          = true,
        force_split          = 0,
    },
})
