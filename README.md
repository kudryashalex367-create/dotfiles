# ʕ•ᴥ•ʔ Arch Linux Dotfiles by zev1ce — Ветка Hyprland (Модульный Lua-конфиг)

<p align="center">
  <img src="https://img.shields.io/badge/OS-Arch_Linux-a78bfa?style=flat-square&logo=archlinux&logoColor=white&labelColor=15111f" alt="Arch Linux">
  <img src="https://img.shields.io/badge/WM-Hyprland-a78bfa?style=flat-square&labelColor=15111f" alt="Hyprland">
  <img src="https://img.shields.io/badge/Packages-GNU_Stow-c4b5fd?style=flat-square&labelColor=15111f" alt="GNU Stow">
  <a href="./LICENSE">
    <img src="https://img.shields.io/badge/License-GPL_v3-c4b5fd?style=flat-square&labelColor=15111f" alt="GNU GPL v3">
  </a>
</p>

> *"I use Arch, btw." — минималистичная 144Hz рабочая станция с динамической темой Material You.*

Ветка [`hyprland`](https://github.com/kudryashalex367-create/dotfiles/tree/hyprland) содержит полную конфигурацию сессии **Hyprland** с нативным модульным Lua-конфигом (`hyprland.lua`), анимациями на физических пружинах, игровым Direct Scanout / Tearing и сквозной динамической темой **Material You** через **matugen 4.x** (fallback — палитра **Obsidian Violet & Soft Lavender**).

> (o_o) **Другие ветки:** основная ветка с сессией **Mango** находится в [`main`](https://github.com/kudryashalex367-create/dotfiles/tree/main), а сессия **Niri** — в ветке [`niri`](https://github.com/kudryashalex367-create/dotfiles/tree/niri).

Разворачивание — через **GNU Stow**: каждый каталог верхнего уровня является отдельным пакетом и линкуется в `$HOME`. Правила агентов лежат в [`AGENTS.md`](./AGENTS.md).

---

## (•̀ᴗ•́)و Содержание

- [Характеристики системы](#specs)
- [Ключевые особенности](#features)
- [Структура репозитория](#structure)
- [Горячие клавиши](#hotkeys)
- [Скрипты и автоматизация](#scripts)
- [Шелл и медиа-пайплайн](#shell)
- [Быстрая установка](#install)
- [Восстановление пакетов](#packages)
- [Темы и сессии](#themes)
- [AI-агент](#ai)
- [Управление конфигами](#manage)

---

<a id="specs"></a>
## (⌐■_■) Характеристики системы

* ʕ•ᴥ•ʔ **OS:** Arch Linux (x86_64)
* (ง'̀-'́)ง **Kernel:** `linux-zen` (с BORE-планировщиком и оптимизацией задержек)
* (๑•̀ㅂ•́)و **CPU:** AMD Ryzen 5 5600H (6C/12T, Zen 3, до 4.28 GHz, 45W TDP)
* (☞ﾟヮﾟ)☞ **GPU:** AMD Radeon Vega 7 / Cezanne (драйвер `amdgpu` + Vulkan RADV + VA-API `radeonsi`)
* (≧▽≦) **Display:** `DP-2` — 1920x1080 @ 144 Hz (с fallback-каскадом `144 → 120 → 60 → preferred`)
* (｡◕‿◕｡) **WM / Session:** Hyprland (нативный модульный Lua-конфиг)
* (✿◠‿◠) **Browser:** Firefox (Wayland-нативный режим, uBlock Origin)
* ( ͡° ͜ʖ ͡°) **Terminal:** Kitty (OpenType-глифы `+ss01 +ss02 +cv01`, Powerline-табы, шлейф курсора)
* (づ｡◕‿‿◕｡)づ **Shell:** Zsh + Oh My Zsh + Starship
* ヽ(´▽`)/ **UI Suite:** Fuzzel (Overlay, скругление 16px), Mako, Hyprlock + Hypridle, awww (144Hz Wipe Engine)
* (⌐■_■) **Theming:** `matugen` 4.x — генерация палитры Material You из обоев для Hyprland, Kitty, Fuzzel, Mako, Hyprlock, GTK 3/4 и Telegram
* (｀・ω・´) **Cursor:** Bibata-Modern-Ice (24px, сквозная синхронизация в Hyprcursor, XCursor и GSettings)
* (ง •̀_•́)ง **Bootloader:** systemd-boot

---

<a id="features"></a>
## ٩(◕‿◕)۶ Ключевые особенности Hyprland-сессии

* (•̀ᴗ•́)و **Модульный Lua-конфиг.** Точка входа `hyprland.lua` загружает 8 модулей: `theme.lua`, `monitors.lua`, `env.lua`, `input.lua`, `animations.lua`, `autostart.lua`, `binds.lua`, `rules.lua`.
* (づ｡◕‿‿◕｡)づ **Динамическая палитра Material You (`matugen 4.x`).** Смена обоев автоматически обновляет границы окон Hyprland, Mako, Kitty, Fuzzel, Hyprlock, GTK 3/4 и тему Telegram Desktop.
* ヽ(´▽`)/ **Физическая пружина в анимациях.** Перемещение окон, смена воркспейсов и выезд scratchpad работают на кастомной пружине `smoothSpring` без лишних колебаний, а открытие окон использует кривую `popIn` с микро-отскоком.
* (ノ°益°)но **Игровой Tearing и Direct Scanout.** Активация `allow_tearing = true` + `render:direct_scanout = true` для Steam-игр и киберспорта.
* ಠ_ಠ **Умная блокировка (`hypridle` + `hyprlock`).** 150 с бездействия → гашение экрана (`dpms off`), 300 с → экран блокировки `hyprlock` с двухэтажными часами и текущим треком.
* (^-^)b **PipeWire-пайплайн.** Аппаратная обработка микрофона `source.clean_mic` и автообъединение аудиоустройств `audio-combine.service`.

---

<a id="structure"></a>
## (o_o) Структура репозитория

```
~/dotfiles/
├── hypr/
│   └── .config/hypr/
│       ├── hyprland.lua        # Точка входа композитора
│       ├── theme.lua           # Внешний вид, рамки, тени, блюр
│       ├── monitors.lua        # Настройки дисплеев и частоты 144Hz
│       ├── env.lua             # Переменные окружения Wayland / Qt / GTK
│       ├── input.lua           # Раскладка клавиатуры, чувствительность мыши
│       ├── animations.lua      # Кривые и пружинные анимации
│       ├── autostart.lua       # Демоны, утилиты и порталы
│       ├── binds.lua           # Горячие клавиши и действия
│       ├── rules.lua           # Правила плавающих окон и исключений
│       ├── hypridle.conf       # Демон тайм-аута экрана и сна
│       └── hyprlock.conf       # Экран блокировки Material You
├── bin/.local/bin/             # Пользовательские скрипты управления
├── kitty/                      # Конфиг Kitty и стили
├── fuzzel/                     # Лаунчер приложений и оверлеи
├── mako/                       # Уведомления Mako
├── matugen/                    # Шаблоны Material You палитры
├── pipewire/                   # Фильтры и маршрутизация звука
├── pkglists/                   # Списки пакетов репозитория и AUR
├── starship/                   # Промпт Starship
├── zsh/                        # Конфиг оболочки zsh
├── install.sh                  # Развёртывание через GNU Stow
└── AGENTS.md                   # Правила для AI-агентов
```

---

<a id="hotkeys"></a>
## (•̀ᴗ•́)و Горячие клавиши (Hyprland)

| Хоткей | Действие |
| :--- | :--- |
| `Super + Return` | Терминал Kitty |
| `Super + D` | Меню приложений Fuzzel |
| `Super + X` | Центр управления Hub |
| `Super + Q` | Закрыть активное окно |
| `Super + V` | Переключить плавающий режим (Float) |
| `Super + F` | Развернуть окно на весь экран |
| `Super + L` | Заблокировать экран (Hyprlock) |
| `Super + Escape` | Меню питания Powermenu |
| `Super + A` / `Super + W` | Случайные обои / Выбор обоев из списка |
| `Super + R` | Переключить разделение тайлов (Dwindle Split) |
| `Super + G` | Создать / войти в группу окон (вкладки) |
| `Super + Shift + P` | Включение / выключение системного прокси |
| `Super + Shift + R` | Перезагрузить Hyprland (`hyprctl reload`) |
| `Super + 1..9` | Переключить воркспейс 1..9 |
| `Super + Shift + 1..9` | Переместить окно на воркспейс 1..9 |
| `Ctrl + Shift + S` | Скриншот выделенной области |
| `Ctrl + Print` | Скриншот всего экрана |
| `Alt + Print` | Скриншот активного окна |

---

<a id="install"></a>
## (•̀ᴗ•́)و Развёртывание с нуля и восстановление

### Шаг 1. Клонирование ветки Hyprland
```bash
git clone -b hyprland https://github.com/kudryashalex367-create/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles"
```

### Шаг 2. Подключение [multilib] и установка пакетов
Перед установкой убедитесь, что в `/etc/pacman.conf` раскомментирован репозиторий `[multilib]`:

```bash
sudo pacman -Syu
sudo pacman -S --needed - < pkglists/.config/pkglist_repo.txt
yay -S --needed - < pkglists/.config/pkglist_aur.txt
```

### Шаг 3. Линковка конфигов через Stow
```bash
cd "$HOME/dotfiles"
./install.sh hypr bin kitty fuzzel mako matugen starship zsh systemd pipewire pkglists
```
*Конфликтующие файлы автоматически перемещаются в `~/dotfiles-backup/stow-<timestamp>/`.*

### Шаг 4. Права, сервисы и запуск
```bash
chmod +x ~/.local/bin/*
systemctl --user daemon-reload
systemctl --user enable --now audio-combine.service 2>/dev/null || true
chsh -s /usr/bin/zsh
```

Запуск сессии:
```bash
Hyprland
```

---

## (︶︹︶) Лицензия

Проект распространяется по лицензии [GNU GPL v3.0](./LICENSE).
