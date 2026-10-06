# Памятка настройки

Конфиги [набора Кирилла Сачкова](https://github.com/KirillSachkov/ai-dev-kit/blob/main/configs/README.md) сверены на macOS 6 октября 2026 года. [YouTube автора](https://www.youtube.com/@SachkovDev) · [Telegram](https://t.me/sachkov_blog).

| Компонент | Файлы набора | Где искать действующие настройки |
|---|---|---|
| Ghostty | [configs/ghostty](https://github.com/KirillSachkov/ai-dev-kit/tree/main/configs/ghostty) | XDG `ghostty/`; на macOS также Application Support |
| Herdr | [configs/herdr](https://github.com/KirillSachkov/ai-dev-kit/tree/main/configs/herdr) | Обычно `~/.config/herdr/`; учитывай `HERDR_CONFIG_PATH` |
| micro | [configs/micro](https://github.com/KirillSachkov/ai-dev-kit/tree/main/configs/micro) | XDG `micro/`; учитывай `MICRO_CONFIG_HOME` и `-config-dir` |
| Yazi | [configs/yazi](https://github.com/KirillSachkov/ai-dev-kit/tree/main/configs/yazi) | XDG `yazi/`; учитывай `YAZI_CONFIG_HOME` |

Это ориентиры. Выясни используемый путь до записи. На другой ОС сверяй доступность выбранных параметров с официальной документацией.

## Особенности компонентов

- Ghostty использует Catppuccin Latte/Mocha, JetBrainsMono Nerd Font Mono 14 и `mouse-scroll-multiplier = precision:1,discrete:1`. Шрифт нужно проверить отдельно. На macOS Application Support может перекрывать XDG-конфиг. Для выбранного файла доступен `ghostty +validate-config --config-file=<путь>`. [Документация](https://ghostty.org/docs/config).
- Herdr использует Ctrl+B и автоматические темы Catppuccin. `ui.sidebar.agents.rows` показывает состояние, проект и вкладку одной строкой. Проверка `HERDR_CONFIG_PATH=<путь> herdr config check` позволяет проверить отдельный файл без записи в живой конфиг. [Документация](https://herdr.dev/docs/configuration/).
- Navigator и reviewr являются необязательными публичными плагинами Herdr. `plugins.json` служит памяткой, а не реестром для импорта. Корни в `navigator.toml` нужно заменить своими. Установка и расположение конфигов описаны в README Herdr.
- Herdr запускает Yazi с `EDITOR=micro VISUAL=micro`. Если пользователь сохраняет редактор, замени эти значения его командой или убери их для наследования окружения.
- micro использует обычные настройки и адаптацию Catppuccin Mocha с MIT-лицензией. Копируй выбранную тему вместе с указанием автора. Для пробы используй `micro -config-dir <временный каталог> <тестовый файл>`. [Оригинальная тема](https://github.com/catppuccin/micro).
- Yazi использует публичные плагины из `package.toml`. Markdown-превью требует glow и piper; открытие JSON и CSV требует jless и csvlens. Отдельной темы Yazi в наборе нет. Пути к стилю glow учитывают `YAZI_CONFIG_HOME` и XDG. [Документация](https://yazi-rs.github.io/docs/configuration/overview/).

Снимок не заменяет проверку выбранного поведения. Полная установка на чистую машину пока не проверена.
