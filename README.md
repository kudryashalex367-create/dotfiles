# 🌌 Arch Linux Dotfiles by zev1ce
> *«I use Arch, btw.»*

Добро пожаловать в мой репозиторий конфигурационных файлов (dotfiles). 
Здесь хранится идеальный, минималистичный и молниеносный сетап моей рабочей станции, основанный на концепции **Git Bare Repository**.

## 💻 Характеристики системы
* **OS:** Arch Linux (x86_64)
* **Kernel:** `linux-zen` (Low-latency)
* **DE/WM:** GNOME (Pure Core) / Wayland
* **Terminal:** Kitty
* **Shell:** Zsh + Oh My Zsh + Powerlevel10k
* **Bootloader:** systemd-boot

---

## 🚀 1. Быстрая установка (Восстановление на чистой ОС)

Этот метод позволяет развернуть все мои настройки на любом новом ПК за 1 минуту без создания симлинков и мусорных папок.

### Шаг 1. Установка базовых зависимостей
Устанавливаем Git, Zsh и скачиваем фреймворк Oh My Zsh:
```bash
sudo pacman -S git zsh curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
Шаг 2. Клонирование темы и плагинов Zsh
Скачиваем Powerlevel10k, автодополнение и подсветку синтаксиса:
code
Bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
Шаг 3. Загрузка базы данных Dotfiles (Bare Repo)
Клонируем историю Git в скрытую папку .cfg (чтобы не замусоривать домашний каталог папкой .git):
code
Bash
git clone --bare https://github.com/kudryashalex367-create/dotfiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
Шаг 4. Распаковка конфигов
Удаляем стандартные файлы (чтобы избежать конфликтов) и физически извлекаем конфиги на диск:
code
Bash
rm -f ~/.zshrc ~/.bashrc ~/.p10k.zsh
config checkout
config config --local status.showUntrackedFiles no
Шаг 5. Применение и запуск!
Меняем дефолтный шелл на Zsh и перезапускаем терминал:
code
Bash
chsh -s /usr/bin/zsh
exec zsh
📦 2. Восстановление всех программ (В 1 клик)
В репозитории лежат файлы pkglist_repo.txt и pkglist_aur.txt. Чтобы автоматически установить весь мой софт на новую систему:
Официальные пакеты Arch:
code
Bash
sudo pacman -S --needed - < ~/.config/pkglist_repo.txt
Пакеты из AUR (требуется yay):
code
Bash
yay -S --needed - < ~/.config/pkglist_aur.txt
