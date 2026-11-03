-- Генерируется matugen из обоев (~/.local/bin/wall-colors).
-- Ручные правки перезапишутся — правь этот шаблон.
-- lua-обёртка Hyprland принимает одиночный цвет и отвергает градиентный
-- суффикс `0deg` ("invalid color"), поэтому здесь только rgba(...).
return {
    active_border   = "rgba(ffb0caff)",
    inactive_border = "rgba(574148ff)",
    shadow_color    = "rgba(1c1014cc)",
}
