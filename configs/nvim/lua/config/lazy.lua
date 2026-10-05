-- Bootstrap adapted from LazyVim/starter under Apache-2.0.
-- Imports and options modified for Kirill Sachkov; see ../../LICENSE-LazyVim-starter.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Failed to install lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" } }, true, {})
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- Навигация: дерево + поиск в одном движке (snacks).
    { import = "lazyvim.plugins.extras.editor.snacks_picker" },
    { import = "lazyvim.plugins.extras.editor.snacks_explorer" },
    -- Оглавление файла: заголовки Markdown, функции и классы в коде.
    { import = "lazyvim.plugins.extras.editor.aerial" },
    -- Форматы, которые ты читаешь чаще всего.
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.toml" },
    { import = "lazyvim.plugins.extras.lang.git" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "plugins" },
  },
  defaults = { lazy = false, version = false },
  install = { colorscheme = { "catppuccin", "habamax" } },
  rocks = { enabled = false },
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
  performance = {
    rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "zipPlugin" } },
  },
})
