# Генерируется matugen из обоев (~/.local/bin/wall-colors).
# Ручные правки перезапишутся — правь этот шаблон.
# wall-colors читает эти переменные и sed-ом подставляет их в
# ~/.config/niri/config.kdl под конкретные ключи:
#   active-gradient from=<F> to=<T>
#   inactive-color <BI>
#   insert-hint color <IH>
#   backdrop-color <BD>
NIRI_ACTIVE_FROM="{{colors.primary.default.hex}}"
NIRI_ACTIVE_TO="{{colors.tertiary.default.hex}}"
NIRI_BORDER_INACTIVE="{{colors.surface_variant.default.hex}}"
NIRI_INSERT_HINT="{{colors.primary.default.hex}}80"
NIRI_BACKDROP="{{colors.background.default.hex}}"
