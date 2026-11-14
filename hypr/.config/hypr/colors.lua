-- Генерируется matugen из обоев (~/.local/bin/wall-colors).
-- Ручные правки перезапишутся — правь этот шаблон.
-- lua-обёртка Hyprland принимает одиночный цвет и отвергает градиентный
-- суффикс `0deg` ("invalid color"), поэтому здесь только rgba(...).
return {
    active_border   = "rgba(ffe45bff)",
    inactive_border = "rgba(4c4733ff)",
    shadow_color    = "rgba(16130acc)",
}
