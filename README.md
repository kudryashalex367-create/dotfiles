# 💜 Arch Linux Dotfiles by zev1ce — Obsidian Violet<p align="center">

<p align="center">
  <img src="https://img.shields.io/badge/OS-Arch_Linux-a78bfa?style=flat-square&logo=archlinux&logoColor=white&labelColor=15111f" alt="Arch Linux">
  <img src="https://img.shields.io/badge/WM-Niri-c4b5fd?style=flat-square&labelColor=15111f" alt="Niri">
  <img src="https://img.shields.io/badge/WM-Hyprland-a78bfa?style=flat-square&labelColor=15111f" alt="Hyprland">
  <img src="https://img.shields.io/badge/DE-Gnome-a78bfa?style=flat-square&labelColor=15111f" alt="Gnome">
  <a href="./LICENSE">
    <img src="https://img.shields.io/badge/License-GPL_v3-c4b5fd?style=flat-square&labelColor=15111f" alt="GNU GPL v3">
  </a>

</p>
> *"I use Arch, btw." — Minimalist 144Hz Scrollable-Tiling & Hybrid Workstation in Deep Midnight & Cyber-Lavender.*

Добро пожаловать в мой репозиторий конфигурационных файлов. Здесь хранится минималистичная, вылизанная и сверхпроизводительная сборка рабочей станции на базе скроллингового тайлинга **Niri WM**, динамического **Hyprland** и классического окружения **GNOME 51**, выполненная в неоновом стиле **Obsidian Violet & Soft Lavender**. Управление конфигурациями реализовано через концепцию **Git Bare Repository**.

---

## 🗺 Содержание

- [Характеристики системы](#-характеристики-системы)
- [Ключевые особенности](#-ключевые-особенности-сборки)
- [Скриншоты](#-скриншоты)
- [Горячие клавиши](#-горячие-клавиши-hotkeys)
- [Быстрая установка](#-быстрая-установка-на-чистую-arch-систему)
- [Восстановление пакетов](#-2-восстановление-пакетов)
- [Управление конфигурациями](#-4-управление-конфигурациями)

## 💻 Характеристики системы

* 🐧 **OS:** Arch Linux (x86_64)
* ⚙️ **Kernel:** `linux-zen` (с BORE-планировщиком и оптимизацией задержек)
* 🧠 **CPU:** AMD Ryzen 5 5600H (6C/12T, Zen 3, до 4.28 GHz, 45W TDP)
* 🎮 **GPU:** AMD Radeon Vega 7 / Cezanne (Открытый драйвер `amdgpu` + Vulkan RADV)
* 🖥️ **Display:** 1920x1080 @ 144 Hz (Аппаратная V-Blank синхронизация)
* 🪟 **WM/DE:** Niri 26.04 (Основная лента) / Hyprland 0.56.2 / GNOME 51 (Медиа)
* 🌐 **Browser:** Firefox (uBlock Origin, Zero-Bloat)
* ⌨️ **Terminal:** Kitty 0.49+ (OpenType глифы `+ss01 +ss02 +cv01`, Powerline-табы, шлейф курсора)
* 🐚 **Shell:** Zsh 5.9.2 + Oh My Zsh + Powerlevel10k (Lean 8-colors)
* 🎨 **UI Suite:** Fuzzel (Overlay скругление 16px), Mako (Obsidian Violet Glass, 23MB RAM), Hyprlock, awww (144Hz Wipe Engine)
* 🖱️ **Cursor:** Bibata-Modern-Ice (24px сквозная синхронизация во всех слоях)
* 🚀 **Bootloader:** systemd-boot

---

## 🌌 Ключевые особенности сборки

* 💜 **Эстетика Obsidian Violet:** Глубочайший космический фон `#0b0912`, лавандовые акценты `#a78bfa`, пастельный ирис `#c4b5fd` и неоновый 45° градиент активного окна в Niri (`#a78bfa` ➔ `#e879f9`).
* 🖤 **Безбаровый Дзен (Barless Setup):** 100% площади экрана отдано коду и контенту — никаких лишних панелей задач и системного мусора.
* 🪐 **Трёхмерный объём и тени:** Окна парят над экраном благодаря мягким рассеянным теням (`#15111fcc`) с радиусом 20–30px.
* 🎯 **Приглушение неактивных окон:** Тонкое затемнение неактивных окон на 5–8% (`dim_inactive` в Hyprland и селектор `is-active=false` в Niri, не ломающий прозрачность при вызове лаунчера).
* 🌊 **Живая кинематика и Overshoot:** Пружины с критическим затуханием (ζ = 1.0) и кривая `popIn` (`0.05 0.9 0.1 1.05`) с лёгким пятипроцентным микро-отскоком при открытии окон.
* 🖱️ **Умный фокус (Strict Hover Focus):** В Niri фокус следует за курсором строго для окон, полностью находящихся в поле зрения (`max-scroll-amount="0%"`), без дерганья ленты.
* 🧊 **Аппаратный Dual-Kawase Блюр:** Чистое матовое стекло без артефактов на скруглениях Fuzzel и Mako (`ignore_alpha` / `geometry-corner-radius 16`).
* ⚡ **Киберспортивный Tearing для игр:** В Hyprland включён моментальный скан-аут (`immediate = true`) строго для игр (CS2), при этом рабочий стол остаётся на 100% плавным без разрывов кадров.
* 🔔 **Ультра-легкий Mako (23 MB RAM):** Моментальные уведомления с отступами `outer-margin=16`, сидящими точно по контуру карточки.
* 🎲 **Рандомайзер обоев (`Win + A`):** Мгновенная плавная смена артов через `awww` на 144 Гц без открытия лишних меню.
* 📱 **Мобильный мост Termux:** Прямая связь со смартфоном по ADB/SSH с поддержкой SponsorBlock и 8-поточного скачивания через `aria2c`.

---

## 📸 Скриншоты

### 🖥️ Рабочий стол Niri (Неоновый градиент и лента)

<img width="1920" height="1080" alt="Рабочий стол Niri" src="https://github.com/user-attachments/assets/9bda9395-cdd8-405f-9b35-91aea3766662" />

### 💻 Kitty (Obsidian Violet + Альтернативные глифы)

<img width="1920" height="1080" alt="Терминал Kitty" src="https://github.com/user-attachments/assets/d9374899-04b3-4da5-84fb-7541dc64075d" />

### 🚀 Меню приложений Fuzzel (Скруглённый выбор)

<img width="1920" height="1080" alt="Меню Fuzzel" src="https://github.com/user-attachments/assets/b00d2c73-017c-4ed6-aa48-d468aa745c5d" />

### 🔒 Двухэтажный экран блокировки (Hyprlock)

<img width="1920" height="1080" alt="hyprlock_showcase" src="https://github.com/user-attachments/assets/85306fb1-9842-45c3-8b25-03149411cd79" />

### ⌨️ Всплывающая шпаргалка по хоткеям (Fuzzel + keybinds)

<img width="1920" height="1080" alt="keybinds_fuzzel" src="https://github.com/user-attachments/assets/4584abe4-04e6-4941-8c3f-42c923e04b09" />

---

## ⌨️ Горячие клавиши (Hotkeys)

Клавиша `Super` (`Mod`) — это клавиша `Windows` на клавиатуре.

### 🚀 Запуск приложений и системных утилит
| Комбинация | Действие |
| :--- | :--- |
| `Super + Enter` | Открыть эмулятор терминала (Kitty) |
| `Super + D` | Меню запуска приложений (Fuzzel) |
| `Super + A` | **Случайные обои в 1 клик с 144Hz wipe-шторкой (`wall-random`)** |
| `Super + W` | Интерактивное меню выбора обоев из `~/wallpapers` (Fuzzel + `awww`) |
| `Super + V` | **Переключить окно в плавающий / тайловый режим (Floating Toggle)** |
| `Super + Shift + V` | **История буфера обмена (Cliphist + Fuzzel)** |
| `Super + N` | Восстановить последнее скрытое уведомление (`makoctl restore`) |
| `Super + Shift + N` | Очистить и закрыть все активные уведомления (`makoctl dismiss -a`) |
| `Super + L` | Заблокировать экран (Hyprlock со сбросом раскладки на US) |
| `Super + O` | Панорамный обзор всех рабочих столов (Overview) |
| `Super + /` *(или `code:61`)* | Всплывающая шпаргалка по хоткеям (работает на US и RU раскладках!) |
| `Super + Space` | Переключение раскладки клавиатуры (US ⇄ RU) |
| `Super + Scroll` | Быстрое переключение рабочих столов колесом мыши |

### 🧱 Управление окнами и колонками (Niri / Hyprland)
| Комбинация | Действие |
| :--- | :--- |
| `Super + Q` | Закрыть активное окно |
| `Super + Shift + E` | Выйти из графической сессии |
| `Super + F` | Развернуть колонку во всю ширину (Maximized) |
| `Super + Shift + F` | Полноэкранный режим (Fullscreen) |
| `Super + R` | Переключить ширину колонки (33% ➔ 50% ➔ 66%) / Сплит |
| `Super + C` | Отцентрировать текущую колонку |
| `Super + -` | Затянуть соседнее окно в текущую колонку (Вертикальный стек) |
| `Super + =` | Вытолкнуть окно из колонки в отдельную |

### 🧭 Навигация и перемещение
| Комбинация | Действие |
| :--- | :--- |
| `Super + ← / →` *(или `H / L`)* | Переход между колонками / окнами (влево / вправо) |
| `Super + Shift + ← / →` | Переместить колонку / окно влево / вправо |
| `Super + Alt + ↓ / ↑` | Переход между окнами внутри одной колонки (вверх / вниз) |
| `Super + Alt + Shift + ↓ / ↑` | Поменять окна местами внутри одной колонки |

### 🔢 Рабочие столы (Workspaces)
| Комбинация | Действие |
| :--- | :--- |
| `Super + ↓ / ↑` *(или `PgUp / PgDn`)* | Переход на рабочий стол ниже / выше |
| `Super + Shift + ↓ / ↑` | Перенести текущую колонку на рабочий стол ниже / выше |
| `Super + 1..9` | Прямой переход на рабочий стол 1..9 |
| `Super + Shift + 1..9` | Перенести колонку / окно на рабочий стол 1..9 |

### 📸 Скриншоты и Мультимедиа
| Комбинация | Действие |
| :--- | :--- |
| `Ctrl + Shift + S` *(или `code:39`)* | Интерактивный скриншот выделенной области в файл и буфер |
| `Ctrl + Print` | Скриншот всего экрана |
| `Alt + Print` | Скриншот активного окна |
| `Media Keys` | Регулировка громкости (`wpctl`) и яркости (`brightnessctl`) |

---

## 🛠 Быстрая установка на чистую Arch-систему

> Сборка рассчитана на Arch Linux x86_64 с AMD GPU.
> На NVIDIA, Intel или других конфигурациях могут потребоваться правки драйверов, VRR, tearing и compositor-настроек.

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

### Шаг 3. Загрузка базы данных Dotfiles (Git Bare) и обоев

```bash
git clone --bare https://github.com/kudryashalex367-create/dotfiles.git $HOME/.cfg
git clone https://github.com/kudryashalex367-create/wallpapers.git ~/wallpapers
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

> ⚠️ **Внимание:** установка перезаписывает существующие dotfiles в `$HOME`.
> Сделай резервную копию важных конфигураций перед продолжением:
>
> ```bash
> mkdir -p ~/dotfiles-backup
> cp -a ~/.zshrc ~/.p10k.zsh ~/.config ~/dotfiles-backup/ 2>/dev/null
> ```

### Шаг 4. Распаковка конфигураций на диск

```bash
mkdir -p ~/dotfiles-backup

for f in ~/.zshrc ~/.bashrc ~/.p10k.zsh ~/README.md; do
  [ -e "$f" ] && mv "$f" ~/dotfiles-backup/
done

config checkout -f
config config --local status.showUntrackedFiles no
```

---

## 📦 2. Восстановление пакетов

### Шаг 1. Официальные пакеты Arch Linux

```bash
sudo pacman -S --needed - < ~/.config/pkglist_repo.txt
```

### Шаг 2. AUR-пакеты через `yay`

```bash
git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay && makepkg -si --noconfirm && cd ~
yay -S --needed - < ~/.config/pkglist_aur.txt
```

---

## 🚀 3. Финальный запуск

```bash
chmod +x ~/.local/bin/* 2>/dev/null || true
fc-cache -fv
chsh -s /usr/bin/zsh
exec zsh
```

---

## 🔄 4. Управление конфигурациями

Управление репозиторием осуществляется через встроенные алиасы и функции в `.zshrc`:

* `config status` — проверить статус измененных файлов.
* `config diff` — просмотреть точные побайтовые изменения перед коммитом.
* `cpush "сообщение"` — автоматически добавить отслеживаемые файлы, закоммитить и запушить в `main`.
* `cpull` — подтянуть свежие изменения с GitHub без лишнего ребейза.
* `aider-dotfiles <файлы>` — запустить терминального AI-ассистента для точечной правки конфигов.

  ## 📄 Лицензия

Проект распространяется по лицензии [GNU GPL v3.0](./LICENSE).
