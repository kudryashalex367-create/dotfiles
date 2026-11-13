-- Генерируется matugen из обоев (~/.local/bin/wall-colors).
-- Ручные правки перезапишутся — правь этот шаблон.
-- lua-обёртка Hyprland принимает одиночный цвет и отвергает градиентный
-- суффикс `0deg` ("invalid color"), поэтому здесь только rgba(...).
return {
    active_border   = "rgba(abc7ffff)",
    inactive_border = "rgba(414753ff)",
    shadow_color    = "rgba(10131acc)",
}
