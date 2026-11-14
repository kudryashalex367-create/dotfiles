# ʕ•ᴥ•ʔ Arch Linux Dotfiles by zev1ce — Hyprland, Mango & Material You

<p align="center">
  <img src="https://img.shields.io/badge/OS-Arch_Linux-a78bfa?style=flat-square&logo=archlinux&logoColor=white&labelColor=15111f" alt="Arch Linux">
  <img src="https://img.shields.io/badge/WM-Hyprland-a78bfa?style=flat-square&labelColor=15111f" alt="Hyprland">
  <img src="https://img.shields.io/badge/WM-Mango-a78bfa?style=flat-square&labelColor=15111f" alt="Mango">
  <img src="https://img.shields.io/badge/Packages-GNU_Stow-c4b5fd?style=flat-square&labelColor=15111f" alt="GNU Stow">
  <a href="./LICENSE">
    <img src="https://img.shields.io/badge/License-GPL_v3-c4b5fd?style=flat-square&labelColor=15111f" alt="GNU GPL v3">
  </a>
</p>

> *"I use Arch, btw." — минималистичная 144Hz рабочая станция с динамической темой Material You.*

Репозиторий конфигов для Arch Linux: основная сессия **Hyprland** с модульным Lua-конфигом, вторая сессия **Mango (mangowm)** с тем же набором биндов и оформления, плюс установленный **GNOME** как запасной вариант. Цвета генерируются из обоев через **matugen** (Material You), fallback — палитра **Obsidian Violet & Soft Lavender**.

Разворачивание — через **GNU Stow**: каждый каталог верхнего уровня является отдельным пакетом и линкуется в `$HOME`. Агентские правила лежат в [`AGENTS.md`](./AGENTS.md).

---

## (•̀ᴗ•́)و Содержание

- [Характеристики системы](#specs)
- [Ключевые особенности](#features)
- [Структура репозитория](#structure)
- [Скриншоты](#screenshots)
- [Горячие клавиши](#hotkeys)
- [Скрипты и автоматизация](#scripts)
- [Шелл, алиасы и медиа-пайплайн](#shell)
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
* (☞ﾟヮﾟ)☞ **GPU:** AMD Radeon Vega 7 / Cezanne (открытый драйвер `amdgpu` + Vulkan RADV + VA-API `radeonsi`)
* (≧▽≦) **Display:** `DP-2` — 1920x1080 @ 144 Hz (с автоматическим fallback-каскадом `144 → 120 → 60 → preferred`)
* (｡◕‿◕｡) **WM / Session:** Hyprland (Lua-конфиг) — основная; Mango — вторая; GNOME (GDM) — запасная
* (✿◠‿◠) **Browser:** Firefox (Wayland-нативный режим, uBlock Origin)
* ( ͡° ͜ʖ ͡°) **Terminal:** Kitty (OpenType-глифы `+ss01 +ss02 +cv01`, Powerline-табы, шлейф курсора)
* (づ｡◕‿‿◕｡)づ **Shell:** Zsh + Oh My Zsh + Starship
* ヽ(´▽`)/ **UI Suite:** Fuzzel (Overlay, скругление 16px), Mako, Hyprlock + Hypridle, awww (144Hz Wipe Engine)
* (⌐■_■) **Theming:** `matugen` 2.x — генерация палитры Material You из обоев для Hyprland, Mango, Kitty, Fuzzel, Mako и Hyprlock (fallback — Obsidian Violet)
* (｀・ω・´) **Cursor:** Bibata-Modern-Ice (24px, сквозная синхронизация в Hyprcursor, XCursor и GSettings)
* (ง •̀_•́)ง **Bootloader:** systemd-boot

---

<a id="features"></a>
## ٩(◕‿◕)۶ Ключевые особенности сборки

* (づ｡◕‿‿◕｡)づ **Две Wayland-сессии.** Hyprland — рабочая, Mango — альтернатива с той же раскладкой биндов, прозрачностью, тенью и блюром. Обе используют общие скрипты из `~/.local/bin` и общую палитру matugen.
* (⚙️‿⚙️) **Модульный Lua-конфиг Hyprland.** Точка входа `hyprland.lua` через `dofile` загружает 8 независимых модулей: `theme`, `monitors`, `env`, `input`, `animations`, `autostart`, `binds`, `rules`.
* ⚙️ **Один конфиг Mango.** `~/.config/mango/config.conf` плюс `autostart.sh` и `source_optional` для сгенерированных `colors.conf` и `proxy.conf`.
* (づ｡◕‿‿◕｡)づ **Динамическая палитра Material You (`matugen`).** Смена обоев автоматически перекрашивает рамки и тени окон Hyprland, Mango, терминал Kitty, лаунчер Fuzzel, уведомления Mako и экран блокировки Hyprlock. Если файл палитры отсутствует, система откатывается к тёмно-фиолетовой схеме **Obsidian Violet** (`#0b0912`, `#a78bfa`, `#c4b5fd`).
* (︶︹︶) **Безбаровый стол.** 100% площади экрана отдано контенту без панелей задач. Воркспейсы `1–5` закреплены как постоянные и не схлопываются при пустоте, навигация замкнута в кольцо.
* (o゜▽゜)o☆ **Выверенный объём и фокус.** Окна обрамлены компактными мягкими тенями (`range = 12`, `render_power = 2`). Неактивные окна приглушаются на **5.5%** (`dim_strength = 0.055`) и получают лёгкую прозрачность `inactive_opacity = 0.975` (у Kitty — отдельное правило `opacity = 0.97 0.95`).
* ヽ(´▽`)/ **Физическая пружина в анимациях.** Перемещение окон, смена воркспейсов и выезд scratchpad работают на кастомной пружине `smoothSpring` без лишних колебаний, а открытие окон использует кривую `popIn` с живым микро-отскоком.
* (⌐■_■) **Чистый аппаратный блюр.** Размытие применяется только к прозрачным оверлеям (`fuzzel`, `mako`, `hyprlock`) и не нагружает GPU под непрозрачными окнами.
* (ノ°益°)ノ **Игровой Tearing и Direct Scanout.** `allow_tearing = true` + `render:direct_scanout = true` + правило `games-tearing` активирует мгновенный вывод кадров для `cs2`, `horizon` и всех игр Steam (`steam_app_*`), сохраняя плавность рабочего стола.
* ಠ_ಠ **Умная блокировка (`hypridle` + `hyprlock`).** Через **150 с** бездействия гаснет экран (`dpms off`), через **300 с** запускается `hyprlock` с двухэтажными часами, индикатором раскладки и текущим треком.
* (•̀ᴗ•́)و **Единый переключатель прокси (`Super + Shift + P`).** Скрипт `proxy` синхронно включает HTTP/SOCKS5-прокси в окружении обоих композиторов, GSettings и `environment.d`, состояние переживает перезагрузку.
* (ง'̀-'́)ง **Агентский регламент.** `AGENTS.md` задаёт границы для opencode/Antigravity: stow-правки только внутри `~/dotfiles`, обязательные проверки, ритуал коммита с подтверждением, запрет секретов.

---

<a id="structure"></a>
## (｀・ω・´) Структура репозитория

Каждый каталог — пакет Stow; путь внутри пакета повторяет путь в `$HOME`.

```text
~/dotfiles
├── install.sh                     # симлинкует все пакеты через stow --no-folding -R
├── AGENTS.md                      # правила для AI-агента
├── ai/.config/opencode/           # конфиг opencode (провайдер AITunnel)
├── bin/.local/bin/                # пользовательские скрипты
│   ├── keybinds                   # живой парсер binds.lua → шпаргалка в Fuzzel
│   ├── nowplaying                 # текущий трек из playerctl для hyprlock
│   ├── proxy                      # менеджер прокси (on/off/toggle/status/restore)
│   ├── screenshot                 # скриншоты (area/window/full) в файл и буфер
│   ├── wall-colors                # пайплайн: matugen + hot-reload (mako, kitty, hyprland, mango)
│   ├── wall-picker                # выбор обоев через Fuzzel + awww + синхронизация
│   ├── wall-random                # случайные обои из ~/wallpapers в 1 клик
│   ├── wall-restore               # восстановление палитры последних обоев при старте
│   └── audio-combine              # объединяет устройства в один sink
├── fastfetch/.config/fastfetch/   # инфо-блок
├── fuzzel/.config/fuzzel/         # лаунчер (генерируется matugen)
├── hypr/.config/hypr/
│   ├── hyprland.lua               # загрузчик модулей (dofile)
│   ├── theme.lua                  # палитра, гапсы, тени (range 12), dim (5.5%), blur, dwindle
│   ├── monitors.lua               # монитор DP-2 (144/120/60 Гц) + persistent workspaces 1–5
│   ├── env.lua                    # курсор Bibata, Wayland-флаги, AMD VA-API (radeonsi)
│   ├── input.lua                  # клавиатура, мышь, DPMS-пробуждение, direct_scanout
│   ├── animations.lua             # пружина smoothSpring и кривые Безье (popIn)
│   ├── autostart.lua              # демоны, cliphist, восстановление палитры и прокси
│   ├── binds.lua                  # все хоткеи, таб-группы, ресайз, прокси, скриншоты
│   ├── rules.lua                  # правила окон (игры, диалоги, PiP, kitty) и слоёв
│   ├── colors.lua                 # динамические цвета рамок и теней (генерируется matugen)
│   ├── hypridle.conf              # таймауты экрана (150 с DPMS off, 300 с hyprlock)
│   └── hyprlock.conf              # экран блокировки (генерируется matugen)
├── kitty/.config/kitty/           # терминал
├── mako/.config/mako/             # уведомления (генерируется matugen)
├── mango/.config/                 # Mango: config.conf, autostart.sh, порталы
├── matugen/.config/matugen/       # config.toml и шаблоны для kitty, mako, hypr, fuzzel, mango
├── pkglists/.config/              # pkglist_repo.txt / pkglist_aur.txt
├── starship/.config/starship.toml # промпт Starship (генерируется matugen)
├── .config/systemd/user/          # unit для audio-combine
└── zsh/                           # .zshrc
```

Сгенерированные matugen файлы — `hypr/colors.lua`, `hyprlock.conf`, `fuzzel.ini`, `mako/config`, `mango/colors.conf`, `starship.toml` — руками не правятся: меняйте шаблоны в `matugen/`.

---

<a id="screenshots"></a>
## (☞ﾟヮﾟ)☞ Скриншоты

### (ง •̀_•́)ง Kitty (Динамическая тема)

<img width="1920" height="1080" alt="kitty_showcase" src="https://github.com/user-attachments/assets/3e5fdd3c-cf52-422c-809b-63b5e370efde" />

### ヽ(´▽`)/ Меню приложений Fuzzel

<img width="1920" height="1080" alt="fuzzel_showcase" src="https://github.com/user-attachments/assets/4631dbc7-7d97-4210-92fb-0f50617a6963" />

### ಠ_ಠ Двухэтажный экран блокировки (Hyprlock)

<img width="1920" height="1080" alt="hyprlock_showcase" src="https://github.com/user-attachments/assets/9035e268-c086-4862-8dbb-2e5b9dc99303" />

### (๑•̀ㅂ•́)و Всплывающая шпаргалка по хоткеям (Fuzzel + keybinds)

<img width="1920" height="1080" alt="keybinds_showcase" src="https://github.com/user-attachments/assets/aac3ccf6-1437-42ee-9e94-db56de700452" />

---

<a id="hotkeys"></a>
## (ง'̀-'́)ง Горячие клавиши

Клавиша `Super` (`Mod`) — клавиша Windows. Полный актуальный список всегда доступен по нажатию `Super + /`. Бинды Mango повторяют Hyprland, кроме отмеченного ниже.

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
| `Super + Shift + P` | **Переключить системный прокси Вкл / Выкл (`proxy toggle`)** |
| `Super + Shift + R` | Перезагрузить конфиг (`hyprctl reload` / `mmsg dispatch reload_config`) |
| `Super + /` *(или `code:61`)* | Всплывающая шпаргалка по хоткеям (работает на US и RU раскладках) |
| `Super + Space` | Переключение раскладки клавиатуры (US ⇄ RU) |
| `Super + L` | Заблокировать экран (`hyprlock` с автосбросом раскладки на US) |
| `Super + Shift + Q` | Выйти из сессии |

### (つ◉益◉)つ Управление окнами и раскладкой
| Комбинация | Действие |
| :--- | :--- |
| `Super + Q` | Закрыть активное окно |
| `Super + V` | Плавающее / плиточное |
| `Super + F` | Развернуть окно с сохранением отступов (`maximized`) |
| `Super + Shift + F` | Настоящий полноэкранный режим (`fullscreen`) |
| `Super + C` | Центрировать плавающее окно |
| `Super + R` | Повернуть направление сплита (`togglesplit` / `dwindle_toggle_current_split`) |
| `Super + P` | Pseudo-tile (только Hyprland) |

### (｀・ω・´) Фокус, перемещение, обмен и ресайз окон
| Комбинация | Действие |
| :--- | :--- |
| `Super + ←/→/↑/↓` | Переместить фокус на соседнее окно по направлению |
| `Super + Shift + ←/→/↑/↓` | Переместить активное окно в указанном направлении |
| `Super + Ctrl + Shift + ←/→/↑/↓` | Поменять активное окно местами с соседним (`swapwindow`) |
| `Super + Ctrl + ←/→/↑/↓` | Изменить размер активного окна с шагом `40px` |
| `Super + Alt + Ctrl + ←/→/↑/↓` | Точный попиксельный ресайз плавающего окна |
| `Super + ЛКМ` / `Super + ПКМ` | Перетаскивание и изменение размера окна мышью |

### (｡◕‿◕｡) Группы окон (табы)
| Комбинация | Действие |
| :--- | :--- |
| `Super + G` | Таб-группа (Hyprland: `togglegroup`, Mango: `groupjoin left`) |
| `Super + Alt + ←/→` | Переключиться на соседнюю вкладку группы |
| `Super + Alt + Shift + ←/→/↑/↓` | Включить активное окно в соседнюю группу |
| `Super + Alt + L` | Hyprland: lockgroups; Mango: показать/скрыть groupbar |

### (✿◠‿◠) Рабочие столы и Scratchpad
| Комбинация | Действие |
| :--- | :--- |
| `Super + 1..9` | Перейти на рабочий стол `1..9` (столы `1–5` постоянные) |
| `Super + Shift + 1..9` | Перенести активное окно на рабочий стол `1..9` |
| `Super + PgUp / PgDn` | Предыдущий / следующий рабочий стол |
| `Super + Колесо вверх/вниз` | Быстрая прокрутка рабочих столов колесом мыши |
| `Super + S` | Показать / скрыть `special:scratchpad` поверх стола |
| `Super + Shift + S` | Тихо отправить активное окно в `special:scratchpad` |

### ( ͡° ͜ʖ ͡°) Скриншоты и мультимедиа
| Комбинация | Действие |
| :--- | :--- |
| `Ctrl + Shift + S` *(или `code:39`)* | Скриншот выбранной области в файл и буфер обмена (US/RU) |
| `Ctrl + Print` | Скриншот всего экрана в файл и буфер обмена |
| `Alt + Print` | Скриншот активного окна |
| `XF86AudioRaiseVolume / LowerVolume` | Громкость `+5%` / `-5%` через `wpctl` |
| `XF86AudioMute / MicMute` | Mute звука / микрофона через `wpctl` |
| `XF86AudioPlay / Next / Prev` | Управление медиаплеером через `playerctl` |

---

<a id="scripts"></a>
## (🛠️‿🛠️) Скрипты и автоматизация (`~/.local/bin`)

* **`wall-colors [--colors-only] <img>`** — ядро динамической темы. Сохраняет путь к обоям в `~/.cache/wall-colors/last`, генерирует тёмную палитру Material You через `matugen` и на лету обновляет цвета в `mako`, `kitty` (`SIGUSR1`), `fuzzel`, `hyprlock`, `Hyprland` (`hyprctl reload`) и `Mango` (`mmsg dispatch reload_config`).
* **`wall-restore`** — запускается при старте сессии, восстанавливает палитру последних обоев из кэша.
* **`wall-random` / `wall-picker`** — выбор случайной картинки или интерактивный поиск через `fuzzel -d`. Смена идёт через `awww` на 144 Гц с эффектом `wipe`, параллельно обновляется фон в GSettings и вызывается `wall-colors`.
* **`proxy {on|off|toggle|status|restore}`** — централизованное управление прокси (`HTTP 127.0.0.1:10809`, `SOCKS5 127.0.0.1:10808`). Синхронно прописывает настройки в переменные окружения Hyprland, Mango (`proxy.conf` + reload), GSettings и `~/.config/environment.d/proxy.conf`. Состояние сохраняется в `~/.local/state/proxy`.
* **`keybinds`** — читает и парсит `~/.config/hypr/binds.lua` при каждом вызове, нормализует названия клавиш и выводит шпаргалку в `fuzzel -d`. Никогда не отстаёт от реального конфига.
* **`screenshot {area|window|full}`** — захват экрана через `grim`, `slurp` и `jq` с одновременным сохранением PNG, копированием в `wl-copy` и уведомлением с миниатюрой.
* **`nowplaying`** — информер для `hyprlock`: берёт метаданные из `playerctl`, обрезает строку до 50 символов и выводит `♪ Исполнитель — Название` (молчит, если ничего не играет).
* **`audio-sink-menu`** — выбор аудиовыхода через Fuzzel.
* **`audio-combine`** — объединяет несколько аудиоустройств в один sink (unit `audio-combine.service`).

---

<a id="shell"></a>
## (づ｡◕‿‿◕｡)づ Шелл, алиасы и медиа-пайплайн (`.zshrc`)

При открытии интерактивного терминала запускается компактный `fastfetch -l arch_small` (подавляется, если шелл вызван внутри AI-агента).

### Медиа и утилиты
* `y <url>` — скачать видео в максимальном качестве в контейнер `mp4` через `yt-dlp`.
* `ya <url>` — скачать аудиодорожку в `~/Music` с вырезанием рекламы через **SponsorBlock**, вшиванием обложки и метаданных.
* `nya [номер_первой_серии] <url1> <url2> ...` — потоковый загрузчик серий аниме в `~/Videos/Anime` с вшиванием субтитров, глав и обложки через `aria2c` (**5 одновременных фрагментов**).
* `phone` — мобильный мост с Termux: `adb forward tcp:8022 tcp:8022` + SSH-сессия на смартфон.
* `update` — быстрое обновление системы и AUR (`yay -Syu`).
* `set-wall <путь>` — быстрая смена обоев через `awww img`.

### Декоративные скринсейверы для терминала
* `matrix` — матрица в пурпурных тонах (`cmatrix -b -C magenta -u 3`).
* `lava` — лава-лампа в терминале (`lavat -c magenta -s 2 -R 1`).
* `zen` — процедурное дерево бонсай (`cbonsai -l -i -w 3 -m "zev1ce"`).
* `clock` — минималистичные терминальные часы (`tty-clock -s -c -b -C 5`).

---

<a id="install"></a>
## (╯°□°)╯ Быстрая установка на чистую Arch-систему

> **Требования:** Arch Linux (x86_64), свежий Hyprland с поддержкой нативного Lua-конфига, Mango (mangowm), matugen 2.x. Сборка заточена под AMD GPU.

### Шаг 1. Базовые зависимости и Oh My Zsh

```bash
sudo pacman -S --needed base-devel git zsh curl starship
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

### Шаг 2. Плагины Zsh

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Шаг 3. Клонирование dotfiles и обоев

```bash
git clone https://github.com/kudryashalex367-create/dotfiles.git "$HOME/dotfiles"
git clone https://github.com/kudryashalex367-create/wallpapers.git "$HOME/wallpapers"
```

### Шаг 4. Разворачивание через Stow

```bash
cd ~/dotfiles
./install.sh
```

`install.sh` переносит конфликтующие файлы в `~/dotfiles-backup/stow-<дата>` и для каждого пакета выполняет `stow --no-folding -R`. Новые, удалённые и переименованные файлы подхватываются только повторным запуском.

---

<a id="packages"></a>
## (づ｡◕‿‿◕｡)づ Восстановление пакетов и финальная настройка

### Официальные пакеты Arch Linux

```bash
sudo pacman -S --needed - < ~/.config/pkglist_repo.txt
```

### AUR-пакеты через `yay`

```bash
git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay && makepkg -si --noconfirm && cd ~
yay -S --needed - < ~/.config/pkglist_aur.txt
```

### Права, шрифты и шелл

```bash
chmod +x ~/.local/bin/*
fc-cache -fv
chsh -s /usr/bin/zsh
```

Mango в этих списках нет — ставится отдельно по инструкции mangowm.

* **Аватар для `hyprlock`:** положите картинку в `~/.config/hypr/assets/avatar.png` и поправьте путь в `matugen/templates/hyprlock.conf`, затем нажмите `Super + A` для генерации темы.
* **Ключ для AI-агента (опционально):** создайте файл `~/.zshrc_secrets` с вашим `export OPENAI_API_KEY="..."` (игнорируется git и защищён от чтения агентом).

Перезапустите оболочку:

```bash
exec zsh
```

---

<a id="themes"></a>
## (｡◕‿◕｡) Темы и сессии

* **Hyprland:** правки Lua-модулей применяются при сохранении; проверка — `hyprctl configerrors`, перезагрузка — `Super + Shift + R`.
* **Mango:** `mmsg dispatch reload_config` (или `Super + Shift + R`); проверки конфига — по логу композитора.
* **Обои и палитра:** `Super + A` / `Super + W` → `awww` → `matugen` → перегенерация файлов и reload во всех сессиях.
* **Fallback:** если `colors.conf` нет, используется Obsidian Violet (`#0b0912`, `#a78bfa`, `#c4b5fd`).

---

<a id="ai"></a>
## (¬‿¬) AI-агент

Конфиги пишутся с помощью [opencode](https://opencode.ai) и [Antigravity](https://antigravity.dev) — провайдер AITunnel, модель DeepSeek V4.1 Flash, README пишет Claude. Правила лежат в [`AGENTS.md`](./AGENTS.md): правки только внутри `~/dotfiles`, запрет `sudo`/`pacman`/`systemctl`/секретов, обязательные проверки, ритуал коммита с подтверждением. Конфиг opencode — в `ai/.config/opencode/opencode.json`, ключ берётся из `OPENAI_API_KEY` (файл `~/.zshrc_secrets`, в git не попадает).

Запуск из каталога дотфайлов: `oc-dots` (opencode) или `agy-dots` (Antigravity).

**Регламент (`AGENTS.md`):**
* **Безопасность:** запрещено вызывать `sudo`, `pacman`/`yay`, `systemctl`, `rm -rf`, перезапускать сессию, использовать сырой `git push` или читать секреты (`~/.zshrc_secrets`, `~/.ssh`, `~/.gnupg`, `.env`).
* **Страховка и бэкапы:** перед правкой «грязных» или неотслеживаемых файлов агент сохраняет копию в `~/dotfiles-backup/agent/<timestamp>/` и следит, чтобы файл не «похудел».
* **Автопроверки:** `hyprctl configerrors` для Hyprland, `zsh -n` / `bash -n` / `shellcheck` для скриптов, `makoctl reload` для уведомлений, `jq` и `tomllib` для JSON/TOML.
* **Ритуал коммита:** агент одной командой собирает `status`, `diff`, `log`, проверяет дифф на утечку ключей/токенов и ждёт явного подтверждения перед `git push`.

---

<a id="manage"></a>
## (≧▽≦) Управление конфигами

```bash
config status        # git -C ~/dotfiles status
config diff          # git -C ~/dotfiles diff
config add -- <file> # взять новый файл под контроль

cpush "сообщение"    # add -u + commit + push origin main (алиас dpush)
cpull                # pull --no-rebase + install.sh + exec zsh
```

Каталог дотфайлов: `$DOTFILES` (`~/dotfiles`). Неотслеживаемые файлы не коммитятся автоматически — `dpush` только предупредит о них.

---

## (︶︹︶) Лицензия

Проект распространяется по лицензии [GNU GPL v3.0](./LICENSE).
