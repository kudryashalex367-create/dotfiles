# ʕ•ᴥ•ʔ Arch Linux Dotfiles by zev1ce — Mango & Material You

<p align="center">
  <img src="https://img.shields.io/badge/OS-Arch_Linux-a78bfa?style=flat-square&logo=archlinux&logoColor=white&labelColor=15111f" alt="Arch Linux">
  <img src="https://img.shields.io/badge/WM-Mango-a78bfa?style=flat-square&labelColor=15111f" alt="Mango">
  <img src="https://img.shields.io/badge/Packages-GNU_Stow-c4b5fd?style=flat-square&labelColor=15111f" alt="GNU Stow">
  <a href="./LICENSE">
    <img src="https://img.shields.io/badge/License-GPL_v3-c4b5fd?style=flat-square&labelColor=15111f" alt="GNU GPL v3">
  </a>
</p>

> *"I use Arch, btw." — минималистичная 144Hz рабочая станция с динамической темой Material You.*

Основная ветка (`main`) репозитория дотфайлов для Arch Linux: сессия **Mango (mangowm)** — быстрый и плавный тайлинговый Wayland-композитор с анимациями, скруглениями, тенями, блюром и кастомной логикой групп. Цвета генерируются из обоев через **matugen 4.x** (Material You), fallback — палитра **Obsidian Violet & Soft Lavender**.

> (o_o) **Другие ветки:** сессия **Hyprland** (полный модульный Lua-конфиг) вынесена в ветку [`hyprland`](https://github.com/kudryashalex367-create/dotfiles/tree/hyprland), а сессия **Niri** — в ветку [`niri`](https://github.com/kudryashalex367-create/dotfiles/tree/niri).

Разворачивание — через **GNU Stow**: каждый каталог верхнего уровня является отдельным пакетом и линкуется в `$HOME`. Агентские правила лежат в [`AGENTS.md`](./AGENTS.md).

---

## (•̀ᴗ•́)و Содержание

- [Характеристики системы](#specs)
- [Ключевые особенности](#features)
- [Структура репозитория](#structure)
- [Горячие клавиши](#hotkeys)
- [Скрипты и автоматизация](#scripts)
- [Шелл, алиасы и медиа-пайплайн](#shell)
- [Быстрая установка](#install)
- [AI-агент](#ai)

---

<a id="specs"></a>
## (⌐■_■) Характеристики системы

* ʕ•ᴥ•ʔ **OS:** Arch Linux (x86_64)
* (ง'̀-'́)ง **Kernel:** `linux-zen` (с BORE-планировщиком и оптимизацией задержек)
* (๑•̀ㅂ•́)و **CPU:** AMD Ryzen 5 5600H (6C/12T, Zen 3, до 4.28 GHz, 45W TDP)
* (☞ﾟヮﾟ)☞ **GPU:** AMD Radeon Vega 7 / Cezanne (открытый драйвер `amdgpu` + Vulkan RADV + VA-API `radeonsi`)
* (≧▽≦) **Display:** `DP-2` — 1920x1080 @ 144 Hz
* (｡◕‿◕｡) **WM / Session:** Mango (mangowm) — основная сессия; GNOME (GDM) — запасная
* (✿◠‿◠) **Browser:** Firefox (Wayland-нативный режим, uBlock Origin)
* ( ͡° ͜ʖ ͡°) **Terminal:** Kitty (начальный размер 960x600, OpenType-глифы `+ss01 +ss02 +cv01`, Powerline-табы, шлейф курсора)
* (づ｡◕‿‿◕｡)づ **Shell:** Zsh + Oh My Zsh + Starship
* ヽ(´▽`)/ **UI Suite:** Fuzzel (Overlay, скругление 16px), Mako, Hyprlock + Hypridle, awww (144Hz Wipe Engine)
* (⌐■_■) **Theming:** `matugen` 4.x — генерация палитры Material You из обоев для Mango, Kitty, Fuzzel, Mako, Hyprlock, GTK 3/4 и Telegram (fallback — Obsidian Violet)
* (｀・ω・´) **Cursor:** Bibata-Modern-Ice (24px, сквозная синхронизация в XCursor и GSettings)
* (ง •̀_•́)ง **Bootloader:** systemd-boot

---

<a id="features"></a>
## ٩(◕‿◕)۶ Ключевые особенности сборки

* (づ｡◕‿‿◕｡)づ **Окружение на Mango.** Чистый и быстрый тайлинг (dwindle / scroller), аппаратный рендеринг, плавные анимации и развитая система тегов и групп окон (`groupjoin`, `togglegroupbar`).
* (•̀ᴗ•́)و **Автоблокировка и экран блокировки.** Mango использует `hypridle` (с адаптивным скриптом `dpms`) и `hyprlock`, которые стилизуются через matugen в единой гамме.
* (◕‿◕) **Единая палитра Material You.** Смена обоев в один клик (`Super + A` / `Super + W`) запускает `matugen 4.x`: перекрашиваются Mango, Kitty, Fuzzel, Mako, Hyprlock, GTK и Telegram Desktop.
* (^-^)b **Медиа-центр и звук.** Fuzzel-меню управления плеерами (`media-menu`), звуковыми выходами и микрофонами (`audio-menu`), автообъединение аудиоустройств через PipeWire (`audio-combine.service`), фоновая запись экрана со звуком (`rec-toggle` / `recvid`).

---

<a id="structure"></a>
## (o_o) Структура репозитория

```
~/dotfiles/
├── bin/
│   ├── .local/bin/
│   │   ├── agy-limits          # Быстрый опрос квот Gemini в Antigravity CLI
│   │   ├── audio-combine       # PipeWire-демон объединения MCHOSE + CMF Buds
│   │   ├── audio-menu          # Fuzzel: громкость, mute, выбор sink/source
│   │   ├── audio-sink-menu     # Быстрое переключение вывода звука
│   │   ├── bluetooth-menu      # Fuzzel: подключение и статус Bluetooth
│   │   ├── dpms                # Управление питанием экрана (Hyprland / Mango)
│   │   ├── hub                 # Центральный пункт управления системой (Super + X)
│   │   ├── keybinds            # Fuzzel: справочник горячих клавиш
│   │   ├── media-menu          # Fuzzel: управление медиаплеерами (playerctl)
│   │   ├── mic-toggle          # Быстрое переключение микрофона с уведомлением
│   │   ├── nowplaying          # Текущий трек для статус-баров и терминала
│   │   ├── powermenu           # Fuzzel: выключение, перезагрузка, сон, блокировка
│   │   ├── proxy               # Управление системным прокси (Mango, env, GSettings)
│   │   ├── rec-toggle          # Фоновая запись экрана со звуком (Super + Alt + R)
│   │   ├── screenshot          # Grim + Slurp скриншоты (область, окно, экран)
│   │   ├── telegram-theme-pack # Сборка и автоприменение темы Telegram Desktop
│   │   ├── wall-colors         # Пайплайн matugen: цвета для всех клиентов
│   │   ├── wall-picker         # Fuzzel: выбор обоев из ~/wallpapers
│   │   ├── wall-random         # Случайные обои с wipe-переходом (awww)
│   │   ├── wall-restore        # Восстановление темы и обоев при старте
│   │   └── wifi-menu           # Fuzzel: выбор сетей Wi-Fi через NetworkManager
│   └── .local/share/applications/ # .desktop файлы для интеграции Fuzzel-меню
├── mango/
│   └── .config/mango/
│       ├── autostart.sh        # Скрипт автозапуска сервисов и демонов
│       └── config.conf         # Основной конфигурационный файл Mango
├── hypr/
│   └── .config/hypr/
│       ├── hypridle.conf       # Демон бездействия (DPMS + запуск hyprlock)
│       └── hyprlock.conf       # Экран блокировки в стиле Material You
├── systemd/
│   └── .config/systemd/user/
│       └── audio-combine.service # Пользовательский сервис автообъединения sink
├── ai/
│   ├── .config/opencode/       # Конфигурация opencode и разрешения безопасности
│   ├── .gemini/config/         # Правила AGENTS.md и хук security-guard для agy
│   └── scripts/install-agy.sh  # Скрипт первоначальной линковки AGY
├── kitty/                      # Конфиг Kitty, табы, шрифты и цвета
├── fuzzel/                     # Меню запуска приложений и оверлеев
├── mako/                       # Демон всплывающих уведомлений
├── matugen/                    # Шаблоны генератора палитры Material You
├── pipewire/                   # Настройки PipeWire
├── pkglists/                   # Списки пакетов для pacman и yay
├── starship/                   # Промпт командной строки Starship
├── zsh/                        # Конфиг оболочки zsh и Oh My Zsh
├── install.sh                  # Скрипт развёртывания через GNU Stow
└── AGENTS.md                   # Единый регламент и правила для AI-агентов
```

---

<a id="hotkeys"></a>
## (•̀ᴗ•́)و Горячие клавиши (Mango)

| Хоткей | Действие |
| :--- | :--- |
| `Super + Return` | Терминал Kitty |
| `Super + D` | Меню приложений Fuzzel |
| `Super + X` | Центр управления Hub |
| `Super + Q` | Закрыть активное окно (`killclient`) |
| `Super + V` | Переключить плавающий / плиточный режим |
| `Super + F` | Развернуть окно на весь тайл |
| `Super + Shift + F` | Полный экран (Fullscreen) |
| `Super + L` | Заблокировать экран (Hyprlock) |
| `Super + Escape` | Меню питания Powermenu |
| `Super + A` / `Super + W` | Случайные обои / Выбор обоев из списка |
| `Super + Tab` | Сменить раскладку окон (dwindle / scroller) |
| `Super + Space` | Переключение раскладки клавиатуры (us / ru) |
| `Super + Shift + M` | Быстрое переключение микрофона |
| `Super + Alt + R` | Запись экрана со звуком (`rec-toggle`) |
| `Super + Shift + P` | Включение / выключение системного прокси |
| `Super + Shift + R` | Перезагрузить конфигурацию Mango (`reload_config`) |
| `Super + G` / `Super + Alt + G` | Добавить окно в группу / Вынуть из группы |
| `Super + Alt + L` | Показать / скрыть панель групп |
| `Super + S` / `Super + Shift + S` | Показать Scratchpad / Отправить в Scratchpad |
| `Super + 1..9` | Переключить рабочий стол (тег 1..9) |
| `Super + Shift + 1..9` | Переместить окно на рабочий стол 1..9 |
| `Super + ЛКМ / ПКМ` | Перетаскивание и ресайз плавающих окон мышью |
| `Ctrl + Shift + S` | Скриншот выделенной области в буфер и файл |
| `Ctrl + Print` | Скриншот всего экрана |
| `Alt + Print` | Скриншот активного окна |

---

<a id="scripts"></a>
## (◕‿◕) Скрипты и автоматизация

* **`rec-toggle`** (`Super + Alt + R`): фоновая запись экрана в MP4 с аппаратным ускорением VA-API. Создаёт виртуальный микшер `rec_mix` в PipeWire, одновременно захватывая чистый микрофон и системный звук (`<sink>.monitor`). По повторному нажатию финализирует файл, выгружает временные модули и копирует путь в буфер (`wl-copy`).
* **`agy-limits`**: считывает текущие квоты моделей Gemini в Antigravity CLI через псевдотерминал и выводит их в аккуратное уведомление Mako.
* **`proxy`**: единое управление локальным прокси (Xray/V2Ray/Mihomo). Применяет настройки в окружение Mango, GSettings (для WebKit/GTK) и `environment.d/proxy.conf` для systemd-сервисов. Команда `proxy restore` при входе ждёт открытия портов до 20 с, не сбрасывая сохранённый статус пользователя.
* **`dpms`**: универсальный переключатель питания дисплеев для `hypridle`.
* **`keybinds`**: статический справочник всех хоткеев Mango в окне Fuzzel (`Super + /`).

---

<a id="shell"></a>
## (づ｡◕‿‿◕｡)づ Шелл, алиасы и медиа-пайплайн

В `.zshrc` настроены полезные утилиты:

* `y <url>` — скачивание видео наилучшего качества через `yt-dlp` в MP4.
* `ya <url>` — скачивание трека с автовырезанием спонсорских интеграций через SponsorBlock.
* `nya [эпизод] <url...>` — пакетное скачивание аниме по сериям с субтитрами через `aria2c`.
* `recvid [area]` — консольная запись экрана со звуком системы и микрофоном в MP4.
* `recmic` — быстрая запись микрофона в WAV с фоновым сжатием в Opus.
* `dots` — быстрый переход в каталог `~/dotfiles`.

---

<a id="install"></a>
## (•̀ᴗ•́)و Быстрая установка

### 1. Подготовка системы
Перед установкой пакетов убедитесь, что в `/etc/pacman.conf` включён репозиторий `[multilib]` (необходим для Steam и 32-битных библиотек):

```bash
# Раскомментируйте секцию [multilib] в /etc/pacman.conf:
# [multilib]
# Include = /etc/pacman.d/mirrorlist
sudo pacman -Syu
```

### 2. Установка пакетов
```bash
# Пакеты из официальных репозиториев
sudo pacman -S --needed - < ~/.config/pkglist_repo.txt

# Пакеты из AUR (через yay)
yay -S --needed - < ~/.config/pkglist_aur.txt
```

### 3. Линковка конфигов через GNU Stow
```bash
cd ~/dotfiles
./install.sh bin mango hypr kitty fuzzel mako matugen starship zsh systemd ai pkglists pipewire
```

### 4. Права, шрифты и сервисы
```bash
# Активация автообъединения аудиоустройств (по желанию)
systemctl --user daemon-reload && systemctl --user enable --now audio-combine.service

# Перезапуск оболочки
exec zsh
```

---

<a id="ai"></a>
## (¬‿¬) AI-агент

Конфиги репозитория поддерживаются с помощью [opencode](https://opencode.ai) и [Antigravity](https://antigravity.dev). Политика безопасности синхронизирована в трёх слоях:
1. **[`AGENTS.md`](./AGENTS.md)** в корне репозитория — единственный источник правды.
2. **`ai/.gemini/config/hooks/security-guard.sh`** — защитный хук Antigravity CLI.
3. **`ai/.config/opencode/opencode.json`** — декларативные разрешения opencode.

**Красные линии:** запрещены `sudo`, `pacman/yay`, `rm -rf` вне dotfiles, изменение секретов (`~/.zshrc_secrets`, `~/.ssh`, `~/.gnupg`, `.env`), `git push --force`. Любой `git push` требует явного подтверждения («да»).
