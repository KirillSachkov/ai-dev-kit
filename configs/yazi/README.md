# Yazi

[yazi.toml](yazi.toml), [keymap.toml](keymap.toml) и [init.lua](init.lua) задают работу с файлами и превью. Публичные плагины перечислены в [package.toml](package.toml); их исходники в набор не входят. Отдельной авторской темы Yazi здесь нет.

Найди действующий каталог Yazi, обычно `~/.config/yazi/`. Учитывай `YAZI_CONFIG_HOME` и XDG. Сохрани свои файлы, сравни клавиши и перенеси выбранные поля. Установи нужные плагины через менеджер Yazi по документации своей версии.

Markdown-превью использует [glow](https://github.com/charmbracelet/glow) и [piper](https://github.com/yazi-rs/plugins/tree/main/piper.yazi). Стиль находится в [glow/style.json](glow/style.json); его цвета используют палитру терминала.

Открытие Markdown через `glow -p` использует внешний просмотрщик из `$PAGER`. Если `$PAGER` не задан, Glow запускает `less -r`. Проверь наличие выбранного просмотрщика и возврат в Yazi после чтения. [Документация Paging](https://github.com/charmbracelet/glow/blob/v2.1.2/README.md#paging). Личный скрипт чтения не требуется.

Для открытия JSON нужен [jless](https://github.com/PaulJuliusMartinez/jless), для CSV нужен [csvlens](https://github.com/YS-L/csvlens). Клавиша `g l` вызывает [lazygit](https://github.com/jesseduffield/lazygit), а поиск может использовать [fd](https://github.com/sharkdp/fd), [ripgrep](https://github.com/BurntSushi/ripgrep) и [fzf](https://github.com/junegunn/fzf). Подключай только выбранные команды.

В Herdr команда Yazi выбирает micro. Сохрани свой редактор через значения `EDITOR` и `VISUAL` в [конфиге Herdr](../herdr/config.toml).

Проверь открытие папки, Markdown-превью, чтение и выбранный редактор. Затем проверь JSON или CSV, если переносил их команды. Снимок сверён с Yazi 26.5.6; `url` и формат `%s` нужно сверить при переносе на другую версию.

[Документация Yazi](https://yazi-rs.github.io/docs/configuration/overview/) · [Все конфиги](../README.md).
