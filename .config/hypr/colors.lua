-- Генерируется matugen из обоев (~/.local/bin/wall-colors).
-- Ручные правки перезапишутся — правь этот шаблон.
-- lua-обёртка Hyprland принимает одиночный цвет и отвергает градиентный
-- суффикс `0deg` ("invalid color"), поэтому здесь только rgba(...).
return {
    active_border   = "rgba(b1c9e4ff)",
    inactive_border = "rgba(43474cff)",
    shadow_color    = "rgba(121315cc)",
}
