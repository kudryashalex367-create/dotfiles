# 🖤 Arch Linux Dotfiles by zev1ce — Monochrome Noir

> *"I use Arch, btw." — Minimalist Scrollable-Tiling & Hybrid Desktop Setup.*

Добро пожаловать в мой репозиторий конфигурационных файлов. Здесь хранится минималистичная, сочная и высокопроизводительная сборка рабочей станции на базе **Niri WM** и **GNOME**, выполненная в строгом ахроматическом стиле **Monochrome Zinc & Obsidian**. Управление конфигурациями реализовано через концепцию **Git Bare Repository**.

---

## 💻 Характеристики системы

* 🐧 **OS:** Arch Linux (x86_64)
* ⚙️ **Kernel:** `linux-zen` (7.1.8-zen)
* 🧠 **CPU:** AMD Ryzen 5 5600H (6C/12T, up to 4.28 GHz)
* 🎮 **GPU:** AMD Radeon Vega / Cezanne (`amdgpu`)
* 🖥️ **Display:** 1920x1080 @ 144 Hz
* 🪟 **WM/DE:** Niri (Scrollable Tiling Wayland) / GNOME (Pure Core)
* ⌨️ **Terminal:** Kitty (Monochrome Obsidian Theme)
* 🐚 **Shell:** Zsh + Oh My Zsh + Powerlevel10k
* 🎨 **UI Suite:** Waybar, Fuzzel, SwayNC, Hyprlock, Swaybg
* 🖱️ **Cursor:** Bibata-Modern-Classic
* 🚀 **Bootloader:** systemd-boot

## 📸 Скриншоты

### 🖥️ Рабочий стол

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/f19bef82-01e9-4a4e-a071-72bc22242b40" />


### 💻 Терминал

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/0a5f0e30-0034-405f-ba91-30a8a292fecf" />


### 🚀 Меню приложений

<img width="1185" height="747" alt="image" src="https://github.com/user-attachments/assets/7d4ec151-c699-4140-9595-d48643947e63" />

---

## ⌨️ Горячие клавиши Niri (Hotkeys)

Клавиша `Super` — это клавиша `Windows` на клавиатуре.

### 🚀 Запуск приложений и системных утилит
| Комбинация | Действие |
| :--- | :--- |
| `Super + Enter` | Открыть терминал Kitty |
| `Super + D` | Меню приложений (Fuzzel) |
| `Super + V` | История буфера обмена (Cliphist + Fuzzel) |
| `Super + N` | Шторка уведомлений и быстрых настроек (SwayNC) |
| `Super + L` | Заблокировать экран (Hyprlock) |
| `Super + Space` | Переключение языка клавиатуры (ENG / RUS) |

### 🧱 Управление окнами и колонками
| Комбинация | Действие |
| :--- | :--- |
| `Super + Q` | Закрыть активное окно |
| `Super + Shift + E` | Выйти из Niri (Завершить сессию) |
| `Super + F` | Развернуть колонку во всю ширину |
| `Super + Shift + F` | Полноэкранный режим (Fullscreen) |
| `Super + R` | Изменить ширину колонки (33% ➔ 50% ➔ 66%) |
| `Super + C` | Отцентрировать текущую колонку |
| `Super + -` | Объединить окно в одну колонку с соседним |
| `Super + =` | Выгнать окно из общей колонки в отдельную |

### 🧭 Навигация и перемещение
| Комбинация | Действие |
| :--- | :--- |
| `Super + ← / →` | Переход между колонками (влево / вправо) |
| `Super + ↑ / ↓` | Переход между окнами в колонке (вверх / вниз) |
| `Super + Shift + ← / →` | Переместить колонку влево / вправо |
| `Super + Shift + ↑ / ↓` | Переместить окно вверх / вниз в колонке |

### 🔢 Рабочие столы (Workspaces)
| Комбинация | Действие |
| :--- | :--- |
| `Super + 1..5` | Переключиться на рабочий стол 1..5 |
| `Super + Shift + 1..5` | Перенести окно на рабочий стол 1..5 |

### 📸 Скриншоты и Мультимедиа
| Комбинация | Действие |
| :--- | :--- |
| `Ctrl + Shift + S` | Интерактивный скриншот (Niri GUI) |
| `Print` | Скриншот выделенной области |
| `Ctrl + Print` | Скриншот всего экрана |
| `Alt + Print` | Скриншот активного окна |
| `Media Keys` | Регулировка громкости (`wpctl`) и яркости |

---

## 🛠 1. Быстрая установка (Восстановление на чистой ОС)

Этот метод позволяет развернуть всю рабочую станцию со всеми программами, шрифтами и темами на новом компьютере за пару минут.

### Шаг 1. Установка базовых зависимостей и Oh My Zsh

Устанавливаем систему контроля версий, командную оболочку, базовые утилиты сборки и Oh My Zsh:

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

Клонируем репозиторий в скрытую папку `.cfg` и создаем временный алиас:

```bash
git clone --bare https://github.com/kudryashalex367-create/dotfiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

### Шаг 4. Распаковка конфигураций на диск

Удаляем дефолтные файлы инициализации и принудительно извлекаем наши конфиги:

```bash
rm -f ~/.zshrc ~/.bashrc ~/.p10k.zsh ~/README.md
config checkout -f
config config --local status.showUntrackedFiles no
```

---

## 📦 2. Восстановление всех пакетов и программ

### Шаг 1. Установка официальных пакетов Arch Linux (pacman)

Восстанавливаем ядро, Niri, GNOME, драйверы, шрифты и утилиты одной командой:

```bash
sudo pacman -S --needed - < ~/.config/pkglist_repo.txt
```

### Шаг 2. Установка AUR-хелпера `yay` и сторонних пакетов

Если `yay` еще не установлен на чистой системе, собираем его в одну строку:

```bash
git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay && makepkg -si --noconfirm && cd ~
```

Теперь восстанавливаем все пакеты из AUR (курсоры Bibata, расширения и утилиты):

```bash
yay -S --needed - < ~/.config/pkglist_aur.txt
```

---

## 🚀 3. Финальный запуск

Обновляем кэш шрифтов, включаем Zsh по умолчанию и перезапускаем оболочку:

```bash
fc-cache -fv
chsh -s /usr/bin/zsh
exec zsh
```

---

## 🔄 4. Управление конфигурациями

Управление репозиторием осуществляется через алиас `config` (он уже прописан в восстановленном `.zshrc`). Работа с ним полностью аналогична работе с обычным `git`.

Проверить статус измененных файлов:
```bash
config status
```

Добавить измененный или новый файл в индекс:
```bash
config add ~/.config/путь_к_файлу
```

Создать коммит и отправить изменения на GitHub:
```bash
config commit -m "Update configs"
config push
```
