# ❄️ Arch Linux Dotfiles by zev1ce

> *"I use Arch, btw."*

Добро пожаловать в мой репозиторий конфигурационных файлов. Здесь хранится минималистичная сборка рабочей станции, основанная на концепции **Git Bare Repository**.

## 💻 Характеристики системы

* 🐧 **OS:** Arch Linux (x86_64)
* ⚙️ **Kernel:** linux-zen
* 🖥️ **DE/WM:** GNOME (Pure Core) / Wayland
* ⌨️ **Terminal:** Kitty
* 🐚 **Shell:** Zsh + Oh My Zsh + Powerlevel10k
* 🚀 **Bootloader:** systemd-boot

---

## 🛠 1. Быстрая установка (Восстановление на чистой ОС)

Этот метод позволяет развернуть все настройки на новом компьютере за пару минут без создания мусорных папок и символических ссылок.

### Шаг 1. Установка базовых зависимостей
Устанавливаем систему контроля версий, командную оболочку и скачиваем фреймворк Oh My Zsh:

```bash
sudo pacman -S git zsh curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
Шаг 2. Клонирование темы и плагинов Zsh
Скачиваем Powerlevel10k, плагины автодополнения и подсветки синтаксиса:
code
Bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
Шаг 3. Загрузка базы данных Dotfiles
Клонируем историю Git в скрытую папку .cfg, чтобы не замусоривать домашний каталог папкой .git, и задаем временный алиас:
code
Bash
git clone --bare https://github.com/kudryashalex367-create/dotfiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
Шаг 4. Распаковка конфигураций
Удаляем стандартные файлы инициализации оболочки для избежания конфликтов и извлекаем конфиги из базы Git на диск. Также скрываем неотслеживаемые файлы, чтобы git status показывал только измененные конфиги:
code
Bash
rm -f ~/.zshrc ~/.bashrc ~/.p10k.zsh
config checkout
config config --local status.showUntrackedFiles no
Шаг 5. Применение настроек
Изменяем командную оболочку по умолчанию на Zsh и перезапускаем ее:
code
Bash
chsh -s /usr/bin/zsh
exec zsh
📦 2. Восстановление пакетов
В репозитории сохранены файлы со списками установленных программ. Чтобы восстановить их списком, выполните следующие команды:
Официальные пакеты Arch Linux (pacman):
code
Bash
sudo pacman -S --needed - < ~/.config/pkglist_repo.txt
Пакеты из пользовательского репозитория (AUR):
(Убедитесь, что у вас установлен yay)
code
Bash
yay -S --needed - < ~/.config/pkglist_aur.txt
🔄 3. Управление конфигурациями
Управление репозиторием осуществляется через алиас config (он уже прописан в восстановленном .zshrc). Работа с ним полностью аналогична работе с обычным git.
Проверить статус измененных файлов:
code
Bash
config status
Добавить измененный или новый файл в индекс:
code
Bash
config add ~/.config/путь_к_файлу
Создать коммит и отправить изменения на сервер:
code
Bash
config commit -am "Update configs"
config push
