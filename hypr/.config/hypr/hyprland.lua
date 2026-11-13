---------------------------
---- CONFIG ENTRYPOINT ----
---------------------------
-- Этап 6: конфиг разбит на модули, этот файл — только загрузчик.
--
-- dofile вместо require:
--   * не зависим от package.path внутри Lua-парсера Hyprland;
--   * hl остаётся глобальным и доступен всем модулям.
--
-- Порядок не критичен (блоки конфигурации независимы), но читать так проще.
local home = os.getenv("HOME") or ""
local dir  = home .. "/.config/hypr"

local modules = {
    "theme",      -- палитра обоев, general/decoration/dwindle
    "monitors",   -- monitor и persistent workspaces 1-5
    "env",        -- XCURSOR, Wayland-нативные приложения, AMD VA-API
    "input",      -- клавиатура/мышь, misc, render, поглощение колеса
    "animations", -- кривые и hl.animation
    "autostart",  -- hl.on("hyprland.start")
    "binds",      -- программы, хоткеи, скриншоты
    "rules",      -- window_rule / layer_rule
}

for _, name in ipairs(modules) do
    dofile(dir .. "/" .. name .. ".lua")
end
