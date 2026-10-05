# Памятка настройки

[Публичный репозиторий](https://github.com/KirillSachkov/ai-dev-kit) содержит конфиги и README инструментов.

Конфиги взяты из окружения Кирилла Сачкова на macOS 4 октября 2026 года. [Канал автора](https://www.youtube.com/@SachkovDev) и [Telegram](https://t.me/sachkov_blog).

| Инструмент | Папка в клоне | Обычное расположение у пользователя |
|---|---|---|
| Ghostty | `configs/ghostty/` | `$XDG_CONFIG_HOME/ghostty/` или `~/.config/ghostty/`; на macOS также Application Support |
| Herdr | `configs/herdr/` | `~/.config/herdr/` |
| Orca | `configs/orca/` | Settings приложения; JSON набора является памяткой |
| Codex | `configs/codex/` | `~/.codex/config.toml`; учти `CODEX_HOME` |
| Claude Code | `configs/claude/` | `~/.claude/settings.json`; учти пользовательские и проектные настройки |
| Neovim | `configs/nvim/` | `~/.config/nvim/`; учти XDG и профиль редактора |
| Yazi | `configs/yazi/` | `~/.config/yazi/`; учти XDG |
| Hunk | `configs/hunk/` | `~/.config/hunk/` |
| zsh | `configs/zsh/` | Фрагмент для `.zshrc`; учти `ZDOTDIR` |

Это ориентиры. Перед записью выясни фактически используемые пути. Читай `configs/README.md` в клоне и README выбранного инструмента.

## Особенности снимка

- Ghostty использует Catppuccin Latte/Mocha и JetBrainsMono Nerd Font Mono. Сначала проверь доступность шрифта и конфликт клавиш с текущими настройками. На macOS позднее загруженный конфиг из Application Support может перекрыть XDG-конфиг. [Документация](https://ghostty.org/docs/config).
- Herdr использует Ctrl+B. Navigator и reviewr устанавливаются отдельно. `plugins.json` перечисляет плагины, но не заменяет внутренний реестр приложения. Проверь пути проектов в `navigator.toml`.
- Codex и Orca содержат режим автора с полными разрешениями. В zsh-фрагменте alias `cld` запускает Claude Code без подтверждений. Перед переносом сохраняй выбранный пользователем режим.
- Orca 1.4.204 передана набором выбранных полей. Поддержка автоматического импорта не подтверждена.
- Neovim основан на LazyVim. Команда «Места агентов» зависит от отсутствующего в наборе `herdr-agent-context`. Не объявляй эту команду настроенной без помощника.
- Yazi использует плагины из `package.toml`, а превью используют glow, eza, jless и csvlens. Скрипт `scripts/md-read.sh` должен быть исполняемым.

После адаптации конфиги пользователя будут отличаться от снимка. Опиши существенные отличия, чтобы человек мог поддерживать свой сетап.
