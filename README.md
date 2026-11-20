# ʕ•ᴥ•ʔ Arch Linux Dotfiles by zev1ce — Ветка Niri (Скроллящийся Wayland-композитор)

<p align="center">
  <img src="https://img.shields.io/badge/OS-Arch_Linux-a78bfa?style=flat-square&logo=archlinux&logoColor=white&labelColor=15111f" alt="Arch Linux">
  <img src="https://img.shields.io/badge/WM-Niri-c4b5fd?style=flat-square&labelColor=15111f" alt="Niri">
  <img src="https://img.shields.io/badge/Branch-niri-a78bfa?style=flat-square&labelColor=15111f" alt="Branch niri">
  <a href="./LICENSE">
    <img src="https://img.shields.io/badge/License-GPL_v3-c4b5fd?style=flat-square&labelColor=15111f" alt="GNU GPL v3">
  </a>
</p>

> *"I use Arch, btw." — минималистичная 144Hz рабочая станция на скроллящемся тайлинге Niri.*

Ветка [`niri`](https://github.com/kudryashalex367-create/dotfiles/tree/niri) содержит полную конфигурацию сессии **Niri** — скроллящегося Wayland-композитора с бесконечной горизонтальной лентой окон, колоночной раскладкой, плавной физикой анимаций, интеграцией `xwayland-satellite` и динамической палитрой Material You через **matugen** (палитра по умолчанию: **Obsidian Violet & Soft Lavender**).

> (o_o) **Другие ветки:** основная ветка с сессией **Mango** находится в [`main`](https://github.com/kudryashalex367-create/dotfiles/tree/main), а сессия **Hyprland** с нативным модульным Lua-конфигом — в ветке [`hyprland`](https://github.com/kudryashalex367-create/dotfiles/tree/hyprland).

---

## (•̀ᴗ•́)و Содержание

- [Характеристики системы](#specs)
- [Ключевые особенности](#features)
- [Горячие клавиши](#hotkeys)
- [Скрипты и окружение](#scripts)
- [Пошаговая установка](#install)
- [Восстановление пакетов](#packages)
- [Управление конфигурацией](#manage)

---

<a id="specs"></a>
## (⌐■_■) Характеристики системы

* ʕ•ᴥ•ʔ **OS:** Arch Linux (x86_64)
* (ง'̀-'́)ง **Kernel:** `linux-zen` (с BORE-планировщиком и оптимизацией интерактивности)
* (๑•̀ㅂ•́)و **CPU:** AMD Ryzen 5 5600H (6C/12T, Zen 3, до 4.28 GHz, 45W TDP)
* (☞ﾟヮﾟ)☞ **GPU:** AMD Radeon Vega 7 / Cezanne (драйвер `amdgpu` + Vulkan RADV + VA-API `radeonsi`)
* (≧▽≦) **Display:** `DP-2` — 1920x1080 @ 144 Hz
* (｡◕‿◕｡) **WM / Session:** Niri (`config.kdl`, скроллящийся тайлинг, dynamic column layout)
* (✿◠‿◠) **Browser:** Firefox (нативный Wayland, аппаратное ускорение VA-API)
* ( ͡° ͜ʖ ͡°) **Terminal:** Kitty (шрифт JetBrains Mono Nerd Font, лигатуры, вкладки)
* (づ｡◕‿‿◕｡)づ **Shell:** Zsh + Oh My Zsh + Powerlevel10k
* ヽ(´▽`)/ **UI Suite:** Fuzzel (меню запуска со скруглением), Mako (уведомления), Hyprlock, awww (144Hz обои)
* (⌐■_■) **Theming:** `matugen` — синхронизация цветовой палитры Material You из текущих обоев
* (｀・ω・´) **Cursor:** Bibata-Modern-Ice (24px, сквозная настройка в XCursor и GSettings)

---

<a id="features"></a>
## ٩(◕‿◕)۶ Ключевые особенности Niri-сессии

* (•̀ᴗ•́)و **Скроллящийся колоночный тайлинг.** Окна не сжимаются до нечитаемых размеров: они выстраиваются в бесконечную горизонтальную ленту колонок. Вы перемещаетесь вдоль ленты, фокусируясь на нужных задачах.
* (ง •̀_•́)ง **Конфигурация в формате KDL.** Все настройки мониторов, устройств ввода, биндов, правил окон и автозапуска описаны в `.config/niri/config.kdl`.
* (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧ **XWayland Satellite.** Полная изоляция и эффективная работа X11-приложений по требованию через отдельный сервис без блокировки основного композитора.
* (｡♥‿♥｡) **Обзор окон (Overview).** Наглядный режим предпросмотра всех открытых окон на экране по клавише `Mod+O`.
* (✿´‿`) **Плавная динамическая физика.** Физические пружины (spring physics) при перемещении, открытии и скролле колонок с нулевым тирингом на 144 Hz.

---

<a id="hotkeys"></a>
## (⌨️_⌨️) Горячие клавиши (Niri)

Модификатор: `Mod` = `Super` (клавиша Windows).

### Навигация и окна

| Сочетание | Действие |
| :--- | :--- |
| `Mod + Return` | Запуск терминала Kitty |
| `Mod + D` | Запуск меню приложений Fuzzel |
| `Mod + Q` | Закрыть активное окно |
| `Mod + O` | Переключить режим обзора (Overview) |
| `Mod + V` | Переключить окно в плавающий / плиточный режим |
| `Mod + Left / Right` или `Mod + H / L` | Фокус на соседнюю колонку слева / справа |
| `Mod + Up / Down` или `Mod + J / K` | Фокус на окно выше / ниже внутри колонки |
| `Mod + Shift + Left / Right` или `H / L` | Переместить колонку влево / вправо |
| `Mod + Shift + Up / Down` или `J / K` | Переместить окно вверх / вниз внутри колонки |
| `Mod + Home / End` | Переход к первой / последней колонке |
| `Mod + 1..9` | Переключение рабочих пространств |
| `Mod + Shift + 1..9` | Перемещение колонки на рабочее пространство |
| `Mod + R` | Режим изменения размера окна (Resize) |
| `Mod + F` | Полноэкранный режим (Fullscreen) |
| `Mod + Shift + E` | Завершить сессию Niri |

### Утилиты и мультимедиа

| Сочетание | Действие |
| :--- | :--- |
| `Mod + L` | Блокировка экрана (Hyprlock с безопасным сбросом раскладки) |
| `Mod + Shift + V` | История буфера обмена (cliphist + Fuzzel) |
| `Mod + A` | Установить случайные обои (`wall-random`) |
| `Mod + W` | Меню выбора обоев (`wall-picker`) |
| `Print` | Интерактивный скриншот области |
| `Mod + Print` | Скриншот всего экрана |
| `Mod + N` | Восстановить последнее уведомление |
| `Mod + Shift + N` | Очистить все уведомления на экране |
| `XF86AudioRaiseVolume` | Увеличить громкость на 5% |
| `XF86AudioLowerVolume` | Уменьшить громкость на 5% |
| `XF86AudioMute` | Заглушить / включить звук |

---

<a id="scripts"></a>
## 🛠️ Скрипты и окружение

Все пользовательские скрипты находятся в `.local/bin` и автоматически доступны в `$PATH`:

* `wall-random` — плавная смена обоев на базе `awww` с анимацией перелистывания (144 fps).
* `wall-restore` — восстановление последних выбранных обоев при старте сессии.
* `wall-picker` — графическое меню выбора фонового рисунка через Fuzzel.
* `screenshot` — скриншоты выделенной области или полного экрана через `grim` и `slurp`.
* `powermenu` — меню управления питанием (сон, перезагрузка, выключение).

---

<a id="install"></a>
## (╯°□°)╯ Быстрая установка

### Шаг 1. Клонирование репозитория

```bash
git clone -b niri https://github.com/kudryashalex367-create/dotfiles.git ~/dotfiles
```

### Шаг 2. Подготовка менеджера пакетов и базы Arch Linux

Убедитесь, что репозиторий `[multilib]` активирован в `/etc/pacman.conf`:

```ini
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Обновите систему и установите помощник AUR (`yay` или `paru`):

```bash
sudo pacman -Syu --needed base-devel git
```

### Шаг 3. Установка пакетов

```bash
cd ~/dotfiles
# Официальные пакеты репозиториев
sudo pacman -S --needed - < .config/pkglist_repo.txt

# Пакеты из пользовательского репозитория AUR
yay -S --needed - < .config/pkglist_aur.txt
```

### Шаг 4. Размещение конфигурационных файлов

В ветке `niri` файлы организованы с прямой структурой `.config/` и `.local/`:

```bash
# Создание базовых каталогов
mkdir -p ~/.config ~/.local/bin

# Копирование / симлинковка конфигураций
cp -rs ~/dotfiles/.config/* ~/.config/
cp -rs ~/dotfiles/.local/bin/* ~/.local/bin/
chmod +x ~/.local/bin/*

# Конфигурация шелла
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.p10k.zsh ~/.p10k.zsh
```

### Шаг 5. Настройка темы курсора и шрифтов

```bash
gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice"
gsettings set org.gnome.desktop.interface cursor-size 24
fc-cache -fv
```

### Шаг 6. Запуск сессии

Запустите Niri через системный дисплейный менеджер (GDM, SDDM, Ly) или напрямую из TTY:

```bash
niri-session
```

---

<a id="packages"></a>
## (ง •̀_•́)ง Восстановление пакетов

Списки пакетов поддерживаются в актуальном состоянии:

* `.config/pkglist_repo.txt` — нативные пакеты официальных репозиториев Arch Linux.
* `.config/pkglist_aur.txt` — пакеты из AUR.

Экспорт текущего набора пакетов системы (при необходимости обновления):

```bash
pacman -Qqe | grep -vx "$(pacman -Qqm)" > ~/dotfiles/.config/pkglist_repo.txt
pacman -Qqm > ~/dotfiles/.config/pkglist_aur.txt
```

---

<a id="manage"></a>
## ( •̀ ω •́ )✧ Управление конфигурацией

Для синхронизации изменений с удалённым репозиторием используйте стандартный рабочий процесс Git:

```bash
cd ~/dotfiles
git status
git add .config/niri/config.kdl
git commit -m "Актуализация параметров раскладки Niri"
git push origin niri
```
