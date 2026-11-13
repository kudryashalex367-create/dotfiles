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

## Содержание

- [Характеристики системы](#specs)
- [Ключевые особенности](#features)
- [Структура репозитория](#structure)
- [Скриншоты](#screenshots)
- [Горячие клавиши](#hotkeys)
- [Скрипты](#scripts)
- [Шелл, алиасы и медиа](#shell)
- [Установка](#install)
- [Пакеты](#packages)
- [Темы и сессии](#themes)
- [AI-агент](#ai)
- [Управление конфигами](#manage)

---

<a id="specs"></a>
## (⌐■_■) Характеристики системы

* **OS:** Arch Linux (x86_64)
* **Kernel:** `linux-zen`
* **CPU:** AMD Ryzen 5 5600H (6C/12T, Zen 3)
* **GPU:** AMD Radeon Vega 7 / Cezanne (`amdgpu`, Vulkan RADV, VA-API `radeonsi`)
* **Display:** `DP-2`, 1920x1080 @ 144 Hz
* **WM / Session:** Hyprland (Lua-конфиг) — основная; Mango — вторая; GNOME (GDM) — запасная
* **Terminal:** Kitty
* **Shell:** Zsh + Oh My Zsh + Starship
* **UI:** Fuzzel, Mako, Hyprlock + Hypridle, awww
* **Theming:** matugen 2.x (Material You из обоев, fallback — Obsidian Violet)
* **Cursor:** Bibata-Modern-Ice (24px)
* **Bootloader:** systemd-boot

---

<a id="features"></a>
## ٩(◕‿◕)۶ Ключевые особенности

* **Две Wayland-сессии.** Hyprland — рабочая, Mango — альтернатива с той же раскладкой биндов, прозрачностью, тенью и блюром. Обе используют общие скрипты из `~/.local/bin` и общую палитру matugen.
* **Модульный Lua-конфиг Hyprland.** Точка входа `hyprland.lua` через `dofile` подключает `theme`, `monitors`, `env`, `input`, `animations`, `autostart`, `binds`, `rules`.
* **Один конфиг Mango.** `~/.config/mango/config.conf` плюс `autostart.sh` и `source_optional` для сгенерированных `colors.conf` и `proxy.conf`.
* **Динамическая палитра.** `matugen` перекрашивает Hyprland, Mango, Kitty, Fuzzel, Mako и Hyprlock при смене обоев. Шаблоны — в `matugen/.config/matugen/templates/`.
* **Безбаровый стол.** Панели задач нет; рабочие столы `1–5` постоянные, навигация замкнута в кольцо.
* **Блюр и прозрачность.** Окна и слои (Fuzzel, Mako) блюрятся, у `slurp` блюр отключён layer-rule. Неактивные окна приглушаются (`dim_strength ≈ 5.5%`), у Kitty отдельная прозрачность.
* **Tearing для игр.** `allow_tearing` + `direct_scanout` (Hyprland), правило `force_tearing`/`no_blur` для `cs2`, `horizon` и `steam_app_*`.
* **Прокси в обеих сессиях.** `proxy toggle` (SUPER+SHIFT+P) синхронизирует env композитора, GSettings и `environment.d`, состояние переживает перезагрузку.
* **Автоблокировка.** `hypridle` гасит экран через 150 с, через 300 с запускает `hyprlock`.
* **Агентский регламент.** `AGENTS.md` задаёт границы для opencode: stow-правки только внутри `~/dotfiles`, проверки, ритуал коммита, запрет секретов.

---

<a id="structure"></a>
## (｀・ω・´) Структура репозитория

Каждый каталог — пакет Stow; путь внутри пакета повторяет путь в `$HOME`.

```text
~/dotfiles
├── install.sh                     # симлинкует все пакеты через stow -R
├── AGENTS.md                      # правила для AI-агента
├── ai/.config/opencode/           # конфиг opencode (провайдер AITunnel)
├── bin/.local/bin/                # пользовательские скрипты
├── fastfetch/.config/fastfetch/   # инфо-блок
├── fuzzel/.config/fuzzel/         # лаунчер (генерируется matugen)
├── hypr/.config/hypr/             # Hyprland: lua-модули, hypridle, hyprlock
├── kitty/.config/kitty/           # терминал
├── mako/.config/mako/             # уведомления (генерируется matugen)
├── mango/.config/                 # Mango: config.conf, autostart.sh, порталы
├── matugen/.config/matugen/       # config.toml и шаблоны
├── pkglists/.config/              # pkglist_repo.txt / pkglist_aur.txt
├── starship/.config/starship.toml # промпт Starship (генерируется matugen)
├── .config/systemd/user/          # unit для audio-combine
└── zsh/                           # .zshrc (p10k-файл оставлен как запасной)
```

Сгенерированные matugen файлы — `hypr/colors.lua`, `hyprlock.conf`, `fuzzel.ini`, `mako/config`, `mango/colors.conf`, `starship.toml` — руками не правятся: меняйте шаблоны в `matugen/`.

---

<a id="screenshots"></a>
## (☞ﾟヮﾟ)☞ Скриншоты

### Kitty

<img width="1920" height="1080" alt="kitty_showcase" src="https://github.com/user-attachments/assets/3e5fdd3c-cf52-422c-809b-63b5e370efde" />

### Fuzzel

<img width="1920" height="1080" alt="fuzzel_showcase" src="https://github.com/user-attachments/assets/4631dbc7-7d97-4210-92fb-0f50617a6963" />

### Hyprlock

<img width="1920" height="1080" alt="изображение" src="https://github.com/user-attachments/assets/9035e268-c086-4862-8dbb-2e5b9dc99303" />

### Шпаргалка по хоткеям

<img width="1920" height="1080" alt="keybinds_showcase" src="https://github.com/user-attachments/assets/aac3ccf6-1437-42ee-9e94-db56de700452" />

---

<a id="hotkeys"></a>
## (ง'̀-'́)ง Горячие клавиши

`Super` (`Mod`) — клавиша Windows. Актуальный список на лету собирает `~/.local/bin/keybinds` (парсит `binds.lua`). Бинды Mango повторяют Hyprland, кроме отмеченного ниже.

### Программы, утилиты и сессия
| Комбинация | Действие |
| :--- | :--- |
| `Super + Enter` | Kitty |
| `Super + D` | Fuzzel |
| `Super + E` | Nautilus |
| `Super + A` / `Super + W` | Случайные обои / выбор обоев + matugen |
| `Super + Shift + V` | История буфера (`cliphist` + Fuzzel) |
| `Super + N` / `Super + Shift + N` | Вернуть / закрыть уведомления |
| `Super + Shift + P` | Прокси вкл/выкл (работает в Hyprland и Mango) |
| `Super + Shift + R` | Перезагрузить конфиг (`hyprctl reload` / `mmsg dispatch reload_config`) |
| `Super + /` или `Super + code:61` | Шпаргалка по хоткеям |
| `Super + Space` | Раскладка US ⇄ RU |
| `Super + L` | Блокировка (`hyprlock`) |
| `Super + Shift + Q` | Выйти из сессии |

### Окна и раскладка
| Комбинация | Действие |
| :--- | :--- |
| `Super + Q` | Закрыть окно |
| `Super + V` | Плавающее / плиточное |
| `Super + F` / `Super + Shift + F` | Maximized / fullscreen |
| `Super + C` | Центрировать плавающее окно |
| `Super + R` | Повернуть сплит (`togglesplit` / `dwindle_toggle_current_split`) |
| `Super + P` | Pseudo-tile (только Hyprland) |

### Фокус, перемещение, ресайз
| Комбинация | Действие |
| :--- | :--- |
| `Super + ←/→/↑/↓` | Фокус |
| `Super + Shift + ←/→/↑/↓` | Переместить окно |
| `Super + Ctrl + Shift + ←/→/↑/↓` | Поменять окна местами |
| `Super + Ctrl + ←/→/↑/↓` | Ресайз с шагом 40px |
| `Super + Alt + Ctrl + ←/→/↑/↓` | Пиксельный ресайз floating |
| `Super + ЛКМ` / `Super + ПКМ` | Перетаскивание / ресайз мышью |

### Группы и столы
| Комбинация | Действие |
| :--- | :--- |
| `Super + G` | Таб-группа (Hyprland: `togglegroup`, Mango: `groupjoin left`) |
| `Super + Alt + ←/→` | Соседняя вкладка группы |
| `Super + Alt + Shift + ←/→/↑/↓` | Добавить окно в группу |
| `Super + Alt + L` | Hyprland: lockgroups; Mango: показать/скрыть groupbar |
| `Super + 1..9` / `Super + Shift + 1..9` | Перейти на стол / перенести окно |
| `Super + PgUp/PgDn`, `Super + колесо` | Соседний стол |
| `Super + S` / `Super + Shift + S` | Scratchpad показать / отправить окно |

### Скриншоты и мультимедиа
| Комбинация | Действие |
| :--- | :--- |
| `Ctrl + Shift + S` (`code:39`) | Скриншот области |
| `Ctrl + Print` | Весь экран |
| `Alt + Print` | Активное окно |
| `XF86Audio*` | Громкость / mute / плеер через `wpctl` и `playerctl` |

---

<a id="scripts"></a>
## (🛠️‿🛠️) Скрипты (`~/.local/bin`)

* **`wall-colors [--colors-only] <img>`** — сохраняет путь обоев, гоняет `matugen` и обновляет Kitty (`SIGUSR1`), Mako, Fuzzel, Hyprlock, Hyprland (`hyprctl reload`) и Mango (`mmsg dispatch reload_config`).
* **`wall-restore`** — восстанавливает палитру последних обоев при старте сессии.
* **`wall-random` / `wall-picker`** — случайные обои / выбор через Fuzzel, смена через `awww`, синхронизация GSettings.
* **`proxy {on|off|toggle|status|restore}`** — HTTP `127.0.0.1:10809`, SOCKS5 `127.0.0.1:10808`, обход локальных сетей. Hyprland — `hyprctl keyword env`; Mango — генерация `~/.config/mango/proxy.conf` + reload; плюс GSettings и `environment.d`. Состояние — `~/.local/state/proxy`.
* **`keybinds`** — парсит `binds.lua` и показывает шпаргалку в Fuzzel.
* **`screenshot {area|window|full}`** — `grim` + `slurp` + `jq`, PNG и `wl-copy`.
* **`nowplaying`** — текущий трек для `hyprlock`.
* **`audio-sink-menu`** — выбор аудиовыхода через Fuzzel.
* **`audio-combine`** — объединяет MCHOSE V9 Pro и CMF Buds 2 Pro в один sink (unit `audio-combine.service`).

---

<a id="shell"></a>
## (づ｡◕‿‿◕｡)づ Шелл, алиасы и медиа

`fastfetch -l arch_small` запускается только в интерактивном шелле и не запускается внутри AI-агента.

* `y <url>` — видео в mp4 через `yt-dlp`; `ya <url>` — аудио с SponsorBlock, обложкой и метаданными.
* `nya [серия] <url...>` — серии аниме в `~/Videos/Anime` с субтитрами и `aria2c`.
* `phone` — `adb forward` + SSH на Termux.
* `update` — `yay -Syu`.
* `set-wall <путь>` — обои через `awww img`.
* Декоративные: `matrix`, `lava`, `zen`, `clock`.

---

<a id="install"></a>
## (╯°□°)╯ Установка

Требования: Arch Linux, свежий Hyprland с поддержкой Lua-конфига, Mango (mangowm), matugen 2.x. Сборка заточена под AMD GPU.

```bash
sudo pacman -S --needed base-devel git zsh curl starship
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/kudryashalex367-create/dotfiles.git "$HOME/dotfiles"
git clone https://github.com/kudryashalex367-create/wallpapers.git "$HOME/wallpapers"
```

Затем:

```bash
cd ~/dotfiles
./install.sh
```

`install.sh` переносит конфликтующие файлы в `~/dotfiles-backup/stow-<дата>` и для каждого пакета выполняет `stow --no-folding -R`. Новые, удалённые и переименованные файлы подхватываются только повторным запуском.

Unit `audio-combine.service` лежит в `.config/systemd/user/` и ставится отдельно (в список пакетов `install.sh` не входит).

---

<a id="packages"></a>
## (づ｡◕‿‿◕｡)づ Пакеты

```bash
sudo pacman -S --needed - < ~/.config/pkglist_repo.txt

git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay && makepkg -si --noconfirm && cd ~
yay -S --needed - < ~/.config/pkglist_aur.txt

chmod +x ~/.local/bin/*
fc-cache -fv
chsh -s /usr/bin/zsh
```

Mango в этих списках нет — ставится отдельно по инструкции mangowm.

---

<a id="themes"></a>
## (｡◕‿◕｡) Темы и сессии

* **Hyprland:** правки Lua-модулей применяются при сохранении; проверка — `hyprctl configerrors`, перезагрузка — `Super + Shift + R`.
* **Mango:** `mmsg dispatch reload_config` (или `Super + Shift + R`); проверки конфига — по логу композитора.
* **Обои и палитра:** `Super + A` / `Super + W` → `awww` → `matugen` → перегенерация файлов и reload.
* **Fallback:** если `colors.conf` нет, используется Obsidian Violet (`#0b0912`, `#a78bfa`, `#c4b5fd`).
* **Аватар для hyprlock:** положите картинку в `~/.config/hypr/assets/avatar.png` и поправьте путь в `matugen/templates/hyprlock.conf`, затем смените обои.

---

<a id="ai"></a>
## (¬‿¬) AI-агент

Конфиги пишутся с помощью [opencode](https://opencode.ai) (провайдер AITunnel, модель DeepSeek V4.1 Flash) и Antigravity. Правила лежат в [`AGENTS.md`](./AGENTS.md): правки только внутри `~/dotfiles`, запрет `sudo`/`pacman`/`systemctl`/секретов, обязательные проверки, ритуал коммита с подтверждением. Конфиг opencode — в `ai/.config/opencode/opencode.json`, ключ берётся из `OPENAI_API_KEY` (файл `~/.zshrc_secrets`, в git не попадает).

Запуск из каталога дотфайлов: `oc-dots` (opencode) или `agy-dots` (Antigravity).

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

Каталог дотфайлов: `$DOTFILES` (`~/dotfiles`). Исходники не отслеживаемых файлов не коммитятся автоматически — `dpush` только предупредит о них.

---

## (︶︹︶) Лицензия

Проект распространяется по лицензии [GNU GPL v3.0](./LICENSE).
