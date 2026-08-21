# 🖤 Arch Linux Dotfiles by zev1ce — Monochrome Obsidian

> *"I use Arch, btw." — Minimalist 144Hz Scrollable-Tiling & Hybrid Dual-Session Workstation.*

Добро пожаловать в мой репозиторий конфигурационных файлов. Здесь хранится минималистичная, сочная и сверхпроизводительная сборка рабочей станции на базе скроллингового тайлинга **Niri WM** и классического окружения **GNOME**, выполненная в строгом ахроматическом стиле **Monochrome Zinc & Obsidian**. Управление конфигурациями реализовано через концепцию **Git Bare Repository**.

---

## 💻 Характеристики системы

* 🐧 **OS:** Arch Linux (x86_64)
* ⚙️ **Kernel:** `linux-cachyos` (7.1.8-1-cachyos с планировщиком BORE и набором инструкций `x86-64-v3`)
* 🧠 **CPU:** AMD Ryzen 5 5600H (6C/12T, Zen 3, up to 4.28 GHz)
* 🎮 **GPU:** AMD Radeon Vega 7 / Cezanne (Открытый драйвер `amdgpu` + Vulkan RADV)
* 🖥️ **Display:** 1920x1080 @ 144 Hz (Аппаратная V-Blank синхронизация)
* 🪟 **WM/DE:** Niri 26.04 (Rust Scrollable Tiling) / GNOME (Pure Core)
* ⌨️ **Terminal:** Kitty (GPU-ускорение, JetBrains Mono Nerd Font, WGPU-блюр)
* 🐚 **Shell:** Zsh 5.9.2 + Oh My Zsh + Powerlevel10k (Lean 8-colors)
* 🎨 **UI Suite:** Fuzzel, SwayNC (Matte Control Center), Hyprlock, awww (144Hz Wallpaper Engine)
* 🖱️ **Cursor:** Bibata-Modern-Ice (24px во всех слоях системы)
* 🚀 **Bootloader:** systemd-boot

---

## 🌌 Ключевые особенности сборки

* 🖤 **Безбаровый Дзен (Barless Setup):** 100% площади экрана отдано контенту и коду — никаких лишних панелей задач и рамок.
* 🌊 **Кинематографичные пружины (Cinematic Silk 144Hz):** Все перемещения окон, скроллинг ленты и зум рассчитываются на пружинной физике Rust в реальном времени.
* 🧊 **Аппаратный WGPU-блюр (Frosted Acrylic):** Двойной проход Kawase-размытия в режиме `xray true` для мгновенного появления окон без задержек.
* 🎛️ **Центр управления SwayNC:** Плотная матовая панель в стиле Obsidian с живыми часами и датой в шапке, ползунками громкости/яркости и универсальными глифами.
* 🔒 **Двухэтажный Hyprlock:** Монументальная вертикальная типографика часов (Nothing OS / Google Pixel style) с защитой от ввода пароля на русской раскладке.
* 🖼️ **Интерактивная смена обоев (`Win + W`):** Быстрый селектор на Fuzzel с плавной анимацией шторки на 144 Гц через `awww` и авто-синхронизацией с GNOME.
* 📱 **Мобильный мост Termux:** Прямая связь со смартфоном по ADB/SSH с поддержкой 8-поточного скачивания видео/аниме/музыки через `aria2c`.

---

## 📸 Скриншоты

### 🖥️ Рабочий стол Niri (Монохромная лента)


<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4dc6d6f2-6cf9-4a72-9a5f-c849a56d28a6" />

### 💻 Kitty

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/68703c54-4b7c-4a81-bcb5-080dfed36607" />

### 🚀 Меню приложений Fuzzel

<img width="1269" height="743" alt="image" src="https://github.com/user-attachments/assets/9f3d762f-c84c-44ac-9617-1d753f863434" />

---

## ⌨️ Горячие клавиши Niri (Hotkeys)

Клавиша `Super` (`Mod`) — это клавиша `Windows` на клавиатуре.

### 🚀 Запуск приложений и системных утилит
| Комбинация | Действие |
| :--- | :--- |
| `Super + Enter` | Открыть терминал Kitty |
| `Super + D` | Меню приложений (Fuzzel) |
| `Super + W` | Интерактивный выбор обоев из `~/wallpapers` (Fuzzel + awww) |
| `Super + V` | История буфера обмена (Cliphist + Fuzzel) |
| `Super + N` | Центр управления и уведомлений с часами (SwayNC) |
| `Super + L` | Заблокировать экран (Hyprlock с авто-сбросом раскладки на US) |
| `Super + O` | Обзор всех рабочих столов (Overview) |
| `Super + /` | Показать интерактивную справку по горячим клавишам |
| `Super + Space` | Переключение раскладки клавиатуры (US / RU) |

### 🧱 Управление окнами и колонками
| Комбинация | Действие |
| :--- | :--- |
| `Super + Q` | Закрыть активное окно |
| `Super + Shift + E` | Выйти из Niri (Завершить сессию) |
| `Super + F` | Развернуть колонку во всю ширину |
| `Super + Shift + F` | Полноэкранный режим (Fullscreen) |
| `Super + R` | Переключить ширину колонки (33% ➔ 50% ➔ 66%) |
| `Super + C` | Отцентрировать текущую колонку |
| `Super + -` | Затянуть соседнее окно в текущую колонку (Вертикальный стек) |
| `Super + =` | Вытолкнуть окно из колонки в отдельную |

### 🧭 Навигация и перемещение
| Комбинация | Действие |
| :--- | :--- |
| `Super + ← / →` | Переход между колонками (влево / вправо) |
| `Super + Shift + ← / →` | Переместить колонку влево / вправо |
| `Super + Alt + ↓ / ↑` | Переход между окнами внутри одной колонки (вверх / вниз) |
| `Super + Alt + Shift + ↓ / ↑` | Поменять окна местами внутри одной колонки |

### 🔢 Рабочие столы (Workspaces)
| Комбинация | Действие |
| :--- | :--- |
| `Super + ↓ / ↑` | Переход на рабочий стол ниже / выше |
| `Super + Shift + ↓ / ↑` | Перенести текущую колонку на рабочий стол ниже / выше |
| `Super + 1..5` | Прямой переход на рабочий стол 1..5 |
| `Super + Shift + 1..5` | Перенести колонку на рабочий стол 1..5 |

### 📸 Скриншоты и Мультимедиа
| Комбинация | Действие |
| :--- | :--- |
| `Ctrl + Shift + S` | Интерактивный скриншот области (Niri GUI) |
| `Ctrl + Print` | Скриншот всего экрана |
| `Alt + Print` | Скриншот активного окна |
| `Media Keys` | Регулировка громкости (`wpctl`) и яркости (`brightnessctl`) |

---

## 🛠 1. Быстрая установка (Восстановление на чистой ОС)

Этот метод позволяет развернуть всю рабочую станцию со всеми программами, шрифтами, анимациями и темами на новом компьютере за пару минут.

### Шаг 1. Установка базовых зависимостей и Oh My Zsh

```bash
sudo pacman -S --needed base-devel git zsh curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

### Шаг 2. Клонирование темы Powerlevel10k и плагинов Zsh

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Шаг 3. Загрузка базы данных Dotfiles (Git Bare)

Клонируем репозиторий в скрытую папку `.cfg` и создаем рабочий алиас:

```bash
git clone --bare https://github.com/kudryashalex367-create/dotfiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

### Шаг 4. Распаковка конфигураций на диск

Удаляем дефолтные файлы инициализации и извлекаем наши конфиги:

```bash
rm -f ~/.zshrc ~/.bashrc ~/.p10k.zsh ~/README.md
config checkout -f
config config --local status.showUntrackedFiles no
```

---

## 📦 2. Восстановление пакетов и ядра

### Шаг 1. Установка официальных пакетов Arch Linux (pacman)

Восстанавливаем ядро CachyOS, Niri, GNOME, драйверы, шрифты и системные утилиты:

```bash
sudo pacman -S --needed - < ~/.config/pkglist_repo.txt
```

### Шаг 2. Установка AUR-хелпера `yay` и сторонних пакетов

Если `yay` еще не установлен на чистой системе, собираем его в одну строку:

```bash
git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay && makepkg -si --noconfirm && cd ~
```

Восстанавливаем AUR-пакеты (курсоры Bibata, расширения и терминальные утилиты):

```bash
yay -S --needed - < ~/.config/pkglist_aur.txt
```

---

## 🚀 3. Финальный запуск

Создаем папку для обоев, настраиваем права на скрипты, обновляем кэш шрифтов и переключаем шелл:

```bash
mkdir -p ~/wallpapers
chmod +x ~/.local/bin/* 2>/dev/null || true
fc-cache -fv
chsh -s /usr/bin/zsh
exec zsh
```

---

## 🔄 4. Управление конфигурациями

Управление репозиторием осуществляется через алиас `config` (он прописан в `.zshrc`). Работа с ним полностью аналогична стандартному `git`.

* Проверить статус измененных файлов:
  ```bash
  config status
  ```
* Добавить измененный файл в индекс:
  ```bash
  config add ~/.config/путь_к_файлу
  ```
* Зафиксировать коммит и отправить на GitHub:
  ```bash
  config commit -m "Update configs"
  config push
  ```
