-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
-- Курсор
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")

-- Wayland-нативность приложений (XWayland остаётся запасным вариантом)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto") -- VS Code, Discord, Obsidian
hl.env("MOZ_ENABLE_WAYLAND", "1")              -- Firefox
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")       -- ";xcb" — fallback, если нет qt6-wayland
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")     -- JetBrains и прочая Java

-- AMD (Mesa): VA-API аппаратное декодирование через radeonsi
hl.env("LIBVA_DRIVER_NAME", "radeonsi")

-- Прокси здесь не задаём: единственный источник правды —
-- ~/.local/bin/proxy {on|off|toggle} (бинд SUPER+SHIFT+P).
-- AUTOSTART вызывает `proxy restore`, чтобы состояние пережило ребут.
