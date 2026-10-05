#!/bin/sh
# Markdown на весь экран для Yazi (Enter на .md): glow рендерит во временный файл, less показывает.
# Не `glow -p`: там glow живёт, пока открыт less, и выход по Ctrl+C или q до конца вывода
# убивал glow сигналом (SIGINT/SIGPIPE), а Yazi показывал «Process terminated by signal».
# Выход: q, Ctrl+C (less -K) или й на русской раскладке (md-read.lesskey).
cols=$(stty size </dev/tty 2>/dev/null | cut -d' ' -f2)
width=$(( ${cols:-100} - 4 ))
[ "$width" -gt 120 ] && width=120
out=$(mktemp -t yazi-md) || exit 1
trap 'rm -f "$out"' EXIT
trap ':' INT
CLICOLOR_FORCE=1 glow -w="$width" -s="$HOME/.config/yazi/glow/style.json" "$1" </dev/null >"$out"
less -RiK --lesskey-src="$HOME/.config/yazi/scripts/md-read.lesskey" "$out"
exit 0  # less -K завершается с кодом 2 по Ctrl+C; для Yazi это обычный выход
