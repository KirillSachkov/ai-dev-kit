# Herdr

[config.toml](config.toml) задаёт Ctrl+B, автоматические темы Catppuccin Latte/Mocha и строки sidebar. Строка агента содержит состояние, проект и вкладку. [Клавиши](cheatsheet.md) · [Файлы и ревью](FILES.md).

Настройки обычно лежат в `~/.config/herdr/`. Если задан `HERDR_CONFIG_PATH`, проверь этот файл. Сохрани текущие настройки и перенеси выбранные поля. В [navigator.toml](navigator.toml) замени пример каталогов Products, Content, Tools, Courses и Personal своими корнями.

[plugins.json](plugins.json) перечисляет публичные плагины снимка и их версии. Файл служит памяткой, а не реестром для импорта. Установи выбранные [Navigator](https://github.com/thanhdat77/herdr-navigator) и [reviewr](https://github.com/persiyanov/herdr-reviewr) по инструкциям авторов.

Настройки Navigator обычно находятся в `~/.config/herdr/navigator.toml`. Настройки reviewr из [reviewr.toml](reviewr.toml) перенеси в `~/.config/herdr/plugins/config/persiyanov.reviewr/config.toml`. Если у тебя там ссылка, сохрани её и измени источник.

Ctrl+B, затем F открывает Yazi с `EDITOR=micro VISUAL=micro`. micro необязателен. Для своего редактора замени эти значения его командой или убери их для наследования окружения.

Из папки набора проверь опубликованный файл:

```bash
HERDR_CONFIG_PATH="$PWD/configs/herdr/config.toml" herdr config check
```

После переноса перечитай конфиг и проверь нужные панели. Плагины и Yazi должны быть установлены отдельно. Снимок сверён с Herdr 0.9.3; для другой версии проверь поддерживаемые поля.

[Документация](https://herdr.dev/docs/configuration/) · [Все конфиги](../README.md).
