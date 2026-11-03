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
