-- Генерируется matugen из обоев (~/.local/bin/wall-colors).
-- Ручные правки перезапишутся — правь этот шаблон.
-- lua-обёртка Hyprland принимает одиночный цвет и отвергает градиентный
-- суффикс `0deg` ("invalid color"), поэтому здесь только rgba(...).
return {
    active_border   = "rgba({{colors.primary.default.hex_stripped}}ff)",
    inactive_border = "rgba({{colors.surface_variant.default.hex_stripped}}ff)",
    shadow_color    = "rgba({{colors.surface.default.hex_stripped}}cc)",
}
