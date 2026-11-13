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

-- Игры: tearing только для игровых окон (главный переключатель allow_tearing = true, без immediate ничего не рвётся).
-- no_blur: блюр под игрой не нужен и зря жжёт GPU в кадре.
hl.window_rule({
    name  = "games-tearing",
    match = {
        class = "^(cs2|steam_app_.*|horizon)$",
    },
    immediate = true,
    no_blur   = true,
})

-- Страховка: kitty всегда открывается в обычном режиме, не fullscreen
hl.window_rule({
    name  = "kitty-no-fullscreen",
    match = {
        class = "^(kitty)$",
    },
    fullscreen = false,
})

-- Лёгкая прозрачность терминала. Значения подобраны так, чтобы текст
-- оставался контрастным; второй параметр — для неактивного окна.
hl.window_rule({
    name    = "kitty-opacity",
    match   = {
        class = "^(kitty)$",
    },
    opacity = "0.97 0.95",
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

-- hyprlock: помечаем слой как blur-capable, чтобы Hyprland не срезал
-- размытие при композиции оверлея блокировки
hl.layer_rule({
    name  = "blur-hyprlock",
    match = {
        namespace = "^(hyprlock)$",
    },
    blur  = true,
})

-- Оверлей выделения области скриншота.
-- Правило с blur=true убрано: у slurp полностью прозрачный фон,
-- поэтому Hyprland размывал весь рабочий стол и выделять было нечего.

-- Системные диалоги — плавающими по центру, а не плиткой
hl.window_rule({
    name  = "float-dialogs",
    match = {
        class = "^(pavucontrol|blueman-manager|nm-connection-editor|org.gnome.FileRoller|hyprland-share-picker)$",
    },
    float  = true,
    center = true,
})

-- Файловые диалоги порталов (GTK/KDE/zenity): открываются поверх,
-- плавающими и по центру, а не делят тайл с основным окном.
hl.window_rule({
    name  = "float-file-dialogs",
    match = {
        class = "^(xdg-desktop-portal-gtk|xdg-desktop-portal-kde|zenity|yad)$",
    },
    float  = true,
    center = true,
})

-- PiP (Firefox/Chrome/YouTube): маленькое окно поверх, по центру.
-- Размер не навязываем — сервис сам выставляет его при первом показе.
hl.window_rule({
    name  = "pip-float",
    match = {
        title = "^(Picture-in-Picture|Picture in picture)$",
    },
    float  = true,
    center = true,
})
