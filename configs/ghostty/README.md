# Ghostty

[Конфиг](config) задаёт Catppuccin Latte/Mocha, JetBrainsMono Nerd Font Mono 14 и клавиши для Herdr. Светлый и тёмный варианты следуют системной теме. `mouse-scroll-multiplier = precision:1,discrete:1` задаёт множители прокрутки для трекпада и колеса. [Клавиши](cheatsheet.md).

Найди действующий конфиг до переноса. Ghostty читает `config.ghostty` и `config` из XDG-каталога, обычно `~/.config/ghostty/`. На macOS файлы в `~/Library/Application Support/com.mitchellh.ghostty/` могут перекрывать значения XDG.

Сохрани текущий файл. Проверь установленный шрифт и перенеси выбранные строки. Сохраняй каждую нужную строку `keybind` отдельно. Параметры с `macos-` и сочетания Cmd относятся к macOS.

Для отдельного файла доступна проверка:

```bash
ghostty +validate-config --config-file=/путь/к/конфигу
```

На macOS нажми Cmd+Shift+, для перечитывания. Проверь тему, шрифт и нужные клавиши в новом окне. Часть настроек требует нового окна или перезапуска.

[Документация](https://ghostty.org/docs/config) · [Справочник параметров](https://ghostty.org/docs/config/reference) · [Все конфиги](../README.md).
