# ʕ•ᴥ•ʔ Arch Linux Dotfiles by zev1ce — Dynamic Material You & Obsidian Violet

<p align="center">
  <img src="https://img.shields.io/badge/OS-Arch_Linux-a78bfa?style=flat-square&logo=archlinux&logoColor=white&labelColor=15111f" alt="Arch Linux">
  <img src="https://img.shields.io/badge/WM-Hyprland-a78bfa?style=flat-square&labelColor=15111f" alt="Hyprland">
  <img src="https://img.shields.io/badge/Session-GNOME-a78bfa?style=flat-square&labelColor=15111f" alt="GNOME">
  <a href="./LICENSE">
    <img src="https://img.shields.io/badge/License-GPL_v3-c4b5fd?style=flat-square&labelColor=15111f" alt="GNU GPL v3">
  </a>
</p>

> *"I use Arch, btw." — Minimalist 144Hz Hybrid Workstation with Dynamic Material You Theming & Obsidian Violet Fallback.*

Добро пожаловать в мой репозиторий конфигурационных файлов. Здесь хранится минималистичная, вылизанная и сверхпроизводительная сборка рабочей станции на базе модульного Lua-конфига **Hyprland** и запасной сессии **GNOME 51**. Основная цветовая схема динамически генерируется из текущих обоев через **matugen** (Material You), а фирменная палитра **Obsidian Violet & Soft Lavender** выступает в качестве базового fallback-профиля. Управление конфигурациями реализовано через концепцию **Git Bare Repository** и автоматизировано с помощью ИИ-агента **Aider**.

> (´・ω・\`) Конфиги **Niri** переехали в отдельную ветку [`niri`](../../tree/niri) — там сохранена прежняя сборка со скроллинговым тайлингом.

---

## (•̀ᴗ•́)و Содержание

- [Характеристики системы](#specs)
- [Ключевые особенности](#features)
- [Архитектура и структура репозитория](#structure)
- [Скриншоты](#screenshots)
- [Горячие клавиши](#hotkeys)
- [Скрипты и автоматизация](#scripts)
- [Шелл, алиасы и медиа-пайплайн](#shell)
- [Быстрая установка](#install)
- [Восстановление пакетов](#packages)
- [Как это сделано (Aider AI-агент)](#how)
- [Управление конфигурациями](#manage)

---

<a id="specs"></a>
## (⌐■_■) Характеристики системы

* ʕ•ᴥ•ʔ **OS:** Arch Linux (x86_64)
* (ง'̀-'́)ง **Kernel:** `linux-zen` (с BORE-планировщиком и оптимизацией задержек)
* (๑•̀ㅂ•́)و **CPU:** AMD Ryzen 5 5600H (6C/12T, Zen 3, до 4.28 GHz, 45W TDP)
* (☞ﾟヮﾟ)☞ **GPU:** AMD Radeon Vega 7 / Cezanne (Открытый драйвер `amdgpu` + Vulkan RADV + VA-API `radeonsi`)
* (≧▽≦) **Display:** `DP-2` — 1920x1080 @ 144 Hz (с автоматическим fallback-каскадом `144 → 120 → 60 → preferred`)
* (｡◕‿◕｡) **WM / Session:** Hyprland 0.56.2 (Модульный Lua-конфиг, основная сессия) / GNOME 51 (GDM + расширения)
* (✿◠‿◠) **Browser:** Firefox (Wayland-нативный режим, uBlock Origin, Zero-Bloat)
* ( ͡° ͜ʖ ͡°) **Terminal:** Kitty 0.49+ (OpenType-глифы `+ss01 +ss02 +cv01`, Powerline-табы, шлейф курсора)
* (づ｡◕‿‿◕｡)づ **Shell:** Zsh 5.9.2 + Oh My Zsh + Powerlevel10k (Lean 8-colors, Transient Prompt)
* ヽ(´▽\`)/ **UI Suite:** Fuzzel (Overlay, скругление 16px), Mako (23MB RAM), Hyprlock + Hypridle, awww (144Hz Wipe Engine)
* (⌐■_■) **Theming:** `matugen` — генерация палитры Material You из обоев для Hyprland, Kitty, Fuzzel, Mako и Hyprlock (fallback — Obsidian Violet)
* (｀・ω・´) **Cursor:** Bibata-Modern-Ice (24px, сквозная синхронизация в Hyprcursor, XCursor и GSettings)
* (ง •̀_•́)ง **Bootloader:** systemd-boot

---

<a id="features"></a>
## ٩(◕‿◕)۶ Ключевые особенности сборки

* (づ｡◕‿‿◕｡)づ **Динамическая палитра Material You (`matugen`):** Смена обоев автоматически перекрашивает рамки и тени окон Hyprland, терминал Kitty, лаунчер Fuzzel, уведомления Mako и экран блокировки Hyprlock. Если файл палитры отсутствует, система мягко откатывается к тёмно-фиолетовой схеме **Obsidian Violet** (`#0b0912`, `#a78bfa`, `#c4b5fd`), которая также используется в `fastfetch`.
* (⚙️‿⚙️) **Модульный Lua-конфиг Hyprland:** Вместо монолитного файла точка входа `hyprland.lua` через `dofile` загружает 8 независимых модулей (`theme`, `monitors`, `env`, `input`, `animations`, `autostart`, `binds`, `rules`).
* (︶︹︶) **Безбаровый Дзен (Barless Setup) и постоянные столы:** 100% площади экрана отдано коду и контенту без панелей задач. Воркспейсы `1–5` закреплены как постоянные (`persistent = true`) и не схлопываются при пустоте, а навигация замкнута в кольцо (`allow_workspace_cycles = true`).
* (o゜▽゜)o☆ **Выверенный объём и фокус:** Окна обрамлены компактными мягкими тенями (`range = 12`, `render_power = 2`). Неактивные окна плавно приглушаются на **5.5%** (`dim_strength = 0.055`) и получают лёгкую прозрачность `inactive_opacity = 0.975` (а для `kitty` задано отдельное правило `opacity = 0.97 0.95`).
* ヽ(´▽\`)/ **Физическая пружина и кинематика Niri:** Перемещение окон, смена воркспейсов и выезд scratchpad работают на кастомной пружине `smoothSpring` (`mass = 1, stiffness = 420, dampening = 46`) без единого лишнего колебания, а открытие окон использует кривую `popIn` (`0.05, 0.9, 0.1, 1.05`) с живым 5%-ным микро-отскоком.
* (⌐■_■) **Чистый аппаратный Блюр:** Размытие (`size = 7, passes = 4`, без зерна) применяется только к прозрачным оверлеям (`fuzzel`, `mako`, `hyprlock`) с отсечением альфа-канала (`ignore_alpha = 0.5`), не нагружая GPU под непрозрачными окнами.
* (ノ°益°)ノ **Игровой Tearing и Direct Scanout:** Глобальный `allow_tearing = true` в связке с `render:direct_scanout = true` и правилом `games-tearing` активирует мгновенный вывод кадров (`immediate = true`) и отключает блюр (`no_blur = true`) для `cs2`, `horizon` и всех игр Steam (`steam_app_*`), сохраняя идеальную плавность рабочего стола.
* ಠ_ಠ **Умная блокировка (`hypridle` + `hyprlock`):** Настольный профиль без принудительного сна: через **150 с** бездействия гаснет экран (`dpms off`, мгновенно просыпается от любого движения мыши или клавиши), а через **300 с** запускается `hyprlock` с двухэтажными часами, индикатором раскладки и текущим треком из `playerctl`.
* (•̀ᴗ•́)و **Единый переключатель прокси (`Super + Shift + P`):** Скрипт `proxy` в один клик включает и выключает HTTP/SOCKS5-прокси синхронно в окружении Hyprland, GSettings (для GTK/WebKit) и `environment.d` (для `systemd --user`), сохраняя состояние между перезагрузками.

---

<a id="structure"></a>
## (｀・ω・´) Архитектура и структура репозитория

```text
$HOME
├── .aiderCode.md                  # ТЗ, правила безопасности и ритуал коммитов для AI-агента Aider
├── .zshrc                         # Конфиг Zsh, алиасы, медиа-функции, bare-git и запуск Aider
├── .p10k.zsh                      # Настройки промпта Powerlevel10k (Lean 8-colors)
├── .config/
│   ├── environment.d/proxy.conf   # Автогенерируемый профиль прокси для systemd --user
│   ├── fastfetch/config.jsonc     # Конфиг системного инфо-блока (Arch Small, лавандовые ключи)
│   ├── fuzzel/fuzzel.ini          # Конфиг лаунчера (генерируется matugen)
│   ├── hypr/
│   │   ├── hyprland.lua           # Загрузчик модулей Hyprland (dofile)
│   │   ├── theme.lua              # Палитра, гапсы, тени (range 12), dim (5.5%), blur, dwindle
│   │   ├── monitors.lua           # Монитор DP-2 (144/120/60 Гц) и persistent workspaces 1–5
│   │   ├── env.lua                # Курсор Bibata, Wayland-флаги, AMD VA-API (radeonsi)
│   │   ├── input.lua              # Клавиатура (40/300), мышь, DPMS-пробуждение, direct_scanout
│   │   ├── animations.lua         # Пружина smoothSpring и кривые Безье (niriEaseOut, popIn)
│   │   ├── autostart.lua          # Демоны, буфер cliphist, восстановление палитры и прокси
│   │   ├── binds.lua              # Все хоткеи, таб-группы, ресайз, прокси и скриншоты
│   │   ├── rules.lua              # Правила окон (игры, диалоги, PiP, kitty) и слоёв (blur)
│   │   ├── colors.lua             # Динамические цвета рамок и теней (генерируется matugen)
│   │   ├── hypridle.conf          # Таймауты экрана (150 с DPMS off, 300 с hyprlock)
│   │   └── hyprlock.conf          # Экран блокировки (генерируется matugen)
│   ├── kitty/
│   │   ├── kitty.conf             # Основной конфиг терминала + статическая база Obsidian Violet
│   │   └── colors.conf            # Динамическая палитра терминала (генерируется matugen)
│   ├── mako/config                # Уведомления (генерируется matugen)
│   ├── matugen/
│   │   ├── config.toml            # Карта шаблонов matugen 2.x
│   │   └── templates/             # Шаблоны для kitty, mako, hypr-colors, fuzzel и hyprlock
│   ├── pkglist_repo.txt           # Список пакетов из официальных репозиториев Arch
│   └── pkglist_aur.txt            # Список пакетов из AUR
└── .local/bin/                    # Пользовательские скрипты
    ├── keybinds                   # Живой парсер binds.lua → шпаргалка в Fuzzel
    ├── nowplaying                 # Текущий трек из playerctl для hyprlock
    ├── proxy                      # Менеджер прокси (on/off/toggle/status/restore)
    ├── screenshot                 # Скриншоты (area/window/full) в файл и буфер
    ├── wall-colors                # Пайплайн: awww + matugen + hot-reload (mako, kitty, hyprland)
    ├── wall-picker                # Выбор обоев через Fuzzel (144Hz wipe + синхронизация с GNOME)
    ├── wall-random                # Случайные обои из ~/wallpapers в 1 клик
    └── wall-restore               # Восстановление палитры последних обоев при старте сессии
```

---

<a id="screenshots"></a>
## (☞ﾟヮﾟ)☞ Скриншоты

### (ง •̀_•́)ง Kitty (Динамическая тема)

<img width="1920" height="1080" alt="kitty_showcase" src="https://github.com/user-attachments/assets/3e5fdd3c-cf52-422c-809b-63b5e370efde" />

### ヽ(´▽\`)/ Меню приложений Fuzzel (Скруглённый выбор)

<img width="1920" height="1080" alt="fuzzel_showcase" src="https://github.com/user-attachments/assets/4631dbc7-7d97-4210-92fb-0f50617a6963" />

### ಠ_ಠ Двухэтажный экран блокировки (Hyprlock)

<img width="1920" height="1080" alt="hyprlock_showcase" src="https://github.com/user-attachments/assets/f714f841-f3cf-4ed2-be20-b22fff5afb06" />

### (๑•̀ㅂ•́)و Всплывающая шпаргалка по хоткеям (Fuzzel + keybinds)

<img width="1920" height="1080" alt="keybinds_showcase" src="https://github.com/user-attachments/assets/aac3ccf6-1437-42ee-9e94-db56de700452" />

---

<a id="hotkeys"></a>
## (ง'̀-'́)ง Горячие клавиши (Hotkeys)

Клавиша `Super` (`Mod`) — это клавиша `Windows`. Полный актуальный список всегда доступен прямо в системе по нажатию `Super + /`.

### (ノ°益°)ノ Программы, утилиты и сессия
| Комбинация | Действие |
| :--- | :--- |
| `Super + Enter` | Открыть терминал (`kitty`) |
| `Super + D` | Меню запуска приложений (`fuzzel`) |
| `Super + E` | Файловый менеджер (`nautilus`) |
| `Super + A` | **Случайные обои с 144Hz wipe-шторкой (`wall-random`) + перегенерация палитры `matugen`** |
| `Super + W` | Меню выбора обоев из `~/wallpapers` (`wall-picker`) + перегенерация палитры `matugen` |
| `Super + Shift + V` | История буфера обмена (`cliphist` + `fuzzel --dmenu` + `wl-copy`) |
| `Super + N` | Вернуть последнее скрытое уведомление (`makoctl restore`) |
| `Super + Shift + N` | Закрыть все активные уведомления (`makoctl dismiss -a`) |
| `Super + Shift + P` | **Переключить системный прокси Вкл / Выкл (`~/.local/bin/proxy toggle`)** |
| `Super + Shift + R` | Перезагрузить конфиг Hyprland (`hyprctl reload`) |
| `Super + /` *(или `code:61`)* | Всплывающая шпаргалка по хоткеям (`~/.local/bin/keybinds`, работает на US и RU раскладках) |
| `Super + Space` | Переключение раскладки клавиатуры (US ⇄ RU) |
| `Super + L` | Заблокировать экран (`hyprlock` с автосбросом раскладки на US и защитой от дублей) |
| `Super + Shift + Q` | Выйти из сессии Hyprland |

### (つ◉益◉)つ Управление окнами и раскладкой
| Комбинация | Действие |
| :--- | :--- |
| `Super + Q` | Закрыть активное окно |
| `Super + V` | Переключить окно в плавающий / плиточный режим (`float`) |
| `Super + F` | Развернуть окно с сохранением отступов (`maximized`) |
| `Super + Shift + F` | Настоящий полноэкранный режим (`fullscreen`) |
| `Super + C` | Центрировать плавающее окно (`center`) |
| `Super + R` | Повернуть направление сплита (`togglesplit`) |
| `Super + P` | Включить режим `pseudo-tile` (окно держит свой размер внутри тайла) |

### (｀・ω・´) Фокус, перемещение, обмен и ресайз окон
| Комбинация | Действие |
| :--- | :--- |
| `Super + ← / → / ↑ / ↓` | Переместить фокус на соседнее окно по направлению |
| `Super + Shift + ← / → / ↑ / ↓` | Переместить активное окно в указанном направлении |
| `Super + Ctrl + Shift + ← / → / ↑ / ↓` | Поменять активное окно местами с соседним (`swapwindow`) |
| `Super + Ctrl + ← / → / ↑ / ↓` | Изменить размер активного окна с шагом `40px` (`resizeactive`) |
| `Super + Alt + Ctrl + ← / → / ↑ / ↓` | Точный попиксельный ресайз плавающего окна (`resizewindowpixel`) |
| `Super + ЛКМ` / `Super + ПКМ` | Перетаскивание (`drag`) и изменение размера (`resize`) окна мышью |

### (｡◕‿◕｡) Группы окон (Табы)
| Комбинация | Действие |
| :--- | :--- |
| `Super + G` | Объединить окно в таб-группу или разобрать её (`togglegroup`) |
| `Super + Alt + ← / →` | Переключиться на предыдущую / следующую вкладку в группе |
| `Super + Alt + Shift + ← / → / ↑ / ↓` | Включить активное окно в соседнюю группу (`moveintogroup`) |
| `Super + Alt + L` | Заблокировать изменение состава групп (`lockgroups lock`) |
| `Super + Alt + Shift + L` | Разблокировать группы (`lockgroups unlock`) |

### (✿◠‿◠) Рабочие столы (Workspaces) и Scratchpad
| Комбинация | Действие |
| :--- | :--- |
| `Super + 1..9` | Перейти на рабочий стол `1..9` (столы `1–5` постоянные) |
| `Super + Shift + 1..9` | Перенести активное окно на рабочий стол `1..9` |
| `Super + PgUp / PgDn` | Перейти на предыдущий / следующий рабочий стол (`e-1` / `e+1`) |
| `Super + Колесо вверх / вниз` | Быстрая прокрутка рабочих столов колесом мыши (событие не утекает в окно) |
| `Super + S` | Показать / скрыть выпадающий `special:scratchpad` поверх стола |
| `Super + Shift + S` | Тихо отправить активное окно в `special:scratchpad` |

### ( ͡° ͜ʖ ͡°) Скриншоты и Мультимедиа
| Комбинация | Действие |
| :--- | :--- |
| `Ctrl + Shift + S` *(или `code:39`)* | Скриншот выбранной области в `~/Pictures/Screenshots` и буфер обмена (работает на US/RU) |
| `Ctrl + Print` | Скриншот всего экрана в файл и буфер обмена |
| `Alt + Print` | Скриншот активного окна (по геометрии из `hyprctl -j activewindow`) |
| `XF86AudioRaiseVolume / LowerVolume` | Громкость динамиков `+5%` / `-5%` через `wpctl` (работает и на заблокированном экране) |
| `XF86AudioMute / MicMute` | Mute звука / микрофона через `wpctl` (работает на заблокированном экране) |
| `XF86AudioPlay / Next / Prev` | Управление медиаплеером через `playerctl` (работает на заблокированном экране) |

---

<a id="scripts"></a>
## (🛠️‿🛠️) Скрипты и автоматизация (`~/.local/bin`)

* **`wall-colors [--colors-only] <img_path>`** — ядро динамической темы. Сохраняет путь к текущим обоям в `~/.cache/wall-colors/last`, генерирует тёмную палитру Material You через `matugen` (по умолчанию `--type scheme-fidelity --prefer saturation`; можно переопределить через переменные окружения `PALETTE_TYPE` и `PALETTE_PREFER`) и на лету обновляет цвета в `mako`, `kitty` (`SIGUSR1`), `fuzzel`, `hyprlock` и `Hyprland` (`hyprctl reload`).
* **`wall-restore`** — запускается при старте Hyprland и восстанавливает палитру последних обоев из кэша. *(Примечание: сейчас `wall-restore` вызывает `matugen` с флагом `--prefer darkness`, а `wall-colors` по умолчанию использует `saturation`, поэтому после перезагрузки оттенок палитры может слегка отличаться от свежевыбранного).*
* **`wall-random` / `wall-picker`** — выбор случайной картинки или интерактивный поиск через `fuzzel -d` из каталога `~/wallpapers`. Смена обоев идёт через `awww` на 144 Гц с эффектом `wipe`, параллельно обновляется фон в GSettings (для синхронизации с сессией GNOME) и вызывается `wall-colors --colors-only`.
* **`proxy {on|off|toggle|status|restore}`** — централизованное управление прокси (`HTTP 127.0.0.1:10809`, `SOCKS5 127.0.0.1:10808`, обход локальных подсетей). Синхронно прописывает настройки в переменные окружения Hyprland, GSettings и `~/.config/environment.d/proxy.conf`, а также выводит уведомление и сохраняет статус в `~/.local/state/proxy`.
* **`keybinds`** — читает и парсит `~/.config/hypr/binds.lua` напрямую при каждом вызове, нормализует названия клавиш и выводит их в `fuzzel -d`. Благодаря этому шпаргалка никогда не отстаёт от реального конфига.
* **`screenshot {area|window|full}`** — захват экрана через `grim`, `slurp` и `jq` с одновременным сохранением PNG, копированием в `wl-copy` и уведомлением с миниатюрой.
* **`nowplaying`** — аккуратный информер для `hyprlock`: берёт метаданные из `playerctl`, очищает висящие тире и суффикс `- YouTube`, обрезает строку до 50 символов и выводит `♪ Исполнитель — Название` (молчит, если ничего не играет).

---

<a id="shell"></a>
## (づ｡◕‿‿◕｡)づ Шелл, алиасы и медиа-пайплайн (`.zshrc`)

При открытии интерактивного терминала запускается компактный `fastfetch -l arch_small` (автоматически подавляется, если шелл вызван внутри сессии Aider).

### Медиа и утилиты
* `y <url>` — скачать видео в максимальном качестве в контейнер `mp4` через `yt-dlp`.
* `ya <url>` — скачать аудиодорожку (`opus`/`m4a`) в `~/Music` с автоматическим вырезанием рекламы, интро и аутро через **SponsorBlock**, вшиванием обложки и метаданных.
* `nya [номер_первой_серии] <url1> <url2> ...` — потоковый загрузчик серий аниме в `~/Videos/Anime` (`Серия_N.mkv`). Автоматически вшивает русские и английские субтитры, главы и обложку, используя `aria2c` в **5 одновременных фрагментов** (`--concurrent-fragments 5`).
* `phone` — мобильный мост с Termux: пробрасывает порт `adb forward tcp:8022 tcp:8022` и сразу открывает SSH-сессию на смартфон.
* `update` — быстрое обновление системы и AUR (`yay -Syu`).
* `set-wall <путь>` — быстрая смена обоев через `awww img`.

### Декоративные скринсейверы для терминала
* `matrix` — матрица в пурпурных тонах (`cmatrix -b -C magenta -u 3`).
* `lava` — лава-лампа в терминале (`lavat -c magenta -s 2 -R 1`).
* `zen` — процедурное дерево бонсай с табличкой (`cbonsai -l -i -w 3 -m "zev1ce"`).
* `clock` — минималистичные терминальные часы (`tty-clock -s -c -b -C 5`).

---

<a id="install"></a>
## (╯°□°)╯ Быстрая установка на чистую Arch-систему

> **Требования:**
> * Arch Linux (`x86_64`), сборка оптимизирована под AMD GPU (`amdgpu` / `radeonsi`). На NVIDIA или Intel проверьте переменные окружения в `.config/hypr/env.lua` и параметры монитора в `.config/hypr/monitors.lua`.
> * Свежий **Hyprland (0.56+)** с поддержкой нативного Lua-конфига (`hyprland.lua`).

### Шаг 1. Базовые зависимости и Oh My Zsh

```bash
sudo pacman -S --needed base-devel git zsh curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

### Шаг 2. Тема Powerlevel10k и плагины Zsh

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Шаг 3. Бэкап старых конфигов, клонирование Dotfiles (Git Bare) и обоев

> (ノಠ益ಠ)ノ **Внимание:** распаковка перезапишет совпадающие файлы в `$HOME`, поэтому сначала переносим существующие конфиги в `~/dotfiles-backup`.

```bash
mkdir -p ~/dotfiles-backup ~/wallpapers
for f in ~/.zshrc ~/.bashrc ~/.p10k.zsh ~/.aiderCode.md ~/README.md ~/.config ~/.local/bin; do
  [ -e "$f" ] && cp -a "$f" ~/dotfiles-backup/ 2>/dev/null
done

git clone --bare https://github.com/kudryashalex367-create/dotfiles.git "$HOME/.cfg"
git clone https://github.com/kudryashalex367-create/wallpapers.git "$HOME/wallpapers"

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout -f
config config --local status.showUntrackedFiles no
```

> (´・ω・\`) Нужна старая сборка с **Niri**? Вместо `config checkout -f` выполните `config checkout -f niri`.

---

<a id="packages"></a>
## (づ｡◕‿‿◕｡)づ Восстановление пакетов и финальная настройка

### Шаг 1. Официальные пакеты Arch Linux

```bash
sudo pacman -S --needed - < ~/.config/pkglist_repo.txt
```

### Шаг 2. AUR-пакеты через `yay`

```bash
git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay && makepkg -si --noconfirm && cd ~
yay -S --needed - < ~/.config/pkglist_aur.txt
```

### Шаг 3. Права, шрифты, аватар и первый запуск

```bash
chmod +x ~/.local/bin/* 2>/dev/null || true
fc-cache -fv
chsh -s /usr/bin/zsh
```

* **Аватар для `hyprlock`:** положите свою картинку в `~/.config/hypr/assets/avatar.png` и при необходимости замените путь `/home/zev1ce/...` на свой домашний каталог в шаблоне `~/.config/matugen/templates/hyprlock.conf`, после чего нажмите `Super + A` для генерации темы.
* **Ключи для Aider (опционально):** если планируете использовать `aider-dotfiles` или `aider-agent`, создайте файл `~/.zshrc_secrets` с вашим `export OPENAI_API_KEY="..."` (он игнорируется git и защищён от чтения агентом).

Перезапустите оболочку:

```bash
exec zsh
```

---

<a id="how"></a>
## (¬‿¬) Как это сделано (Aider AI-агент)

Честно: основную часть конфигов и скриптов пишет ИИ. С тех пор как я начал работать через [aider](https://aider.chat) (модель DeepSeek V4.1 Flash), на него приходится примерно 4/5 добавленных строк в этом репозитории, а README пишет Claude. Моя часть: ставлю задачи, читаю диффы, проверяю ошибки конфигов на своей системе и решаю, что оставить, а что откатить.

Чтобы агент не сломал живую систему в `$HOME`, в корне репозитория лежит жёсткий регламент **`.aiderCode.md`**:
* **Безопасность:** агенту запрещено вызывать `sudo`, `pacman`/`yay`, `systemctl`, `rm -rf`, перезапускать сессию, использовать сырой `git push` или читать секреты (`~/.zshrc_secrets`, `~/.ssh`, `~/.gnupg`, `.env`).
* **Страховка и бэкапы:** перед правкой файлов с незакоммиченными изменениями или неотслеживаемых файлов агент автоматически сохраняет копию в `~/dotfiles-backup/aider/<timestamp>/` и следит, чтобы файл случайно не «похудел».
* **Автопроверки после каждой правки:** `hyprctl configerrors` для Hyprland, `zsh -n` / `bash -n` / `shellcheck` для скриптов, `makoctl reload` для уведомлений, валидация `jq` и `tomllib` для JSON/TOML.
* **Ритуал коммита:** агент одной командой собирает `status`, `diff`, `log`, проверяет дифф регуляркой на утечку ключей/токенов, формулирует короткое описание на русском и ждёт моего явного подтверждения перед запуском `cpush`.

Если интересно, как это видно в истории: коммиты без галочки Verified сделаны через aider, а с галочкой — это правки через веб-интерфейс GitHub.

---

<a id="manage"></a>
## (≧▽≦) Управление конфигурациями

Управление bare-репозиторием осуществляется через встроенные алиасы и функции в `.zshrc`:

* `config status` — проверить статус отслеживаемых файлов.
* `config diff` — просмотреть точные изменения перед коммитом.
* `config add -- <файл>` — взять новый файл под контроль версий (так как `status.showUntrackedFiles` выключен, новые файлы не видны, пока их не добавят явно).
* `cpush "сообщение"` — автоматически проиндексировать все изменённые отслеживаемые файлы (`config add -u`), создать коммит и запушить в ветку `main`.
* `cpull` — подтянуть свежие изменения с GitHub (`--no-rebase`) и перезапустить `zsh`.
* `aider-dotfiles <файлы>` — запустить интерактивного AI-ассистента Aider в режиме ручного подтверждения.
* `aider-agent` — запустить автономного агента (`agentaider --yes-always`) с автоматическим чтением правил из `.aiderCode.md`.
* `~/.local/bin/wall-colors <путь_к_обоям>` — вручную применить обои, пересобрать палитру `matugen` и перезагрузить все компоненты.

---

## (︶︹︶) Лицензия

Проект распространяется по лицензии [GNU GPL v3.0](./LICENSE).%
