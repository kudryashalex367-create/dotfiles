---------------
---- INPUT ----
---------------
hl.config({
    input = {
        -- Раскладка и переключение по Win+Space
        kb_layout  = "us,ru",
        kb_options = "grp:win_space_toggle",

        -- Дефолт 25/600 ощущается вязким при наборе и удержании стрелок
        repeat_rate  = 40,
        repeat_delay = 300,

        follow_mouse = 1,
        sensitivity  = -0.4, -- Скорость мыши (как mouse: accel-speed -0.4)
    },

    -- Курсор не мешает при наборе текста (аналог hide-when-typing в niri)
    cursor = {
        hide_on_key_press = true,
    },
})

-- VFR в новых версиях Hyprland управляется автоматически:
-- опция misc:vfr удалена, задавать её больше не нужно.
hl.config({
    misc = {
        disable_hyprland_logo        = true,
        disable_splash_rendering     = true,
        animate_manual_resizes       = false,
        animate_mouse_windowdragging = false,

        -- Экран, погашенный hypridle (dpms off), просыпается от ввода.
        -- Без этого on-resume hypridle остаётся единственным триггером
        -- и монитор включается с задержкой.
        mouse_move_enables_dpms      = true,
        key_press_enables_dpms       = true,
    },
})

-- AMD + Wayland: прямой скан-аут для fullscreen-игр снижает задержку
-- (композитор отдаёт кадр в plane напрямую). Если в твоей версии
-- Hyprland ключа ещё нет — configerrors покажет, тогда блок убрать.
hl.config({
    render = {
        direct_scanout = true,
    },
})

--------------------------------
---- MOUSE EVENT CONSUMPTION ----
--------------------------------
-- Бинды на колесо (SUPER + scroll) не должны доходить до приложения:
-- без этого терминал одновременно листает историю при смене воркспейса.
-- pass_mouse_when_bound гасит только кнопки мыши; для колеса (axis events)
-- отдельный ключ scroll_event_delay — без него событие успевает утечь
-- в окно до того, как сработает бинд.
hl.config({
    binds = {
        pass_mouse_when_bound = false,
        scroll_event_delay    = 0,

        -- Как в Niri: возврат на прошлый воркспейс, скрытие special при
        -- смене воркспейса и циклы (9 → 1) вместо упора в край.
        workspace_back_and_forth         = true,
        hide_special_on_workspace_change = true,
        allow_workspace_cycles           = true,
    },
})
