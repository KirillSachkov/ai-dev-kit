# Yazi (если используешь)
if command -v yazi >/dev/null 2>&1; then
  function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      cd -- "$cwd"
    fi
    rm -f -- "$tmp"
  }
fi


export EDITOR="nvim"
export VISUAL="nvim"
alias cl="claude"
alias cld="claude --dangerously-skip-permissions"
alias cx="codex"
alias lg="lazygit"
alias lzd="lazydocker"
