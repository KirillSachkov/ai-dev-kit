-- Свои клавиши поверх LazyVim. Все стандартные: https://www.lazyvim.org/keymaps
-- Найти любую клавишу по описанию: Space s k.
local map = vim.keymap.set

map("n", "<leader>?", function()
  require("kirill.help").open()
end, { desc = "Шпаргалка" })

-- Путь к файлу для агента: «src/app.ts:42» или «src/app.ts:42-57» из выделения.
map({ "n", "x" }, "<leader>fy", function()
  local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":~:.")
  local from, to = vim.fn.line("v"), vim.fn.line(".")
  if from > to then
    from, to = to, from
  end
  local ref = vim.fn.mode():match("[vV\22]") and from ~= to and ("%s:%d-%d"):format(path, from, to)
    or ("%s:%d"):format(path, to)
  vim.fn.setreg("+", ref)
  vim.notify("Скопировано: " .. ref)
end, { desc = "Скопировать путь:строку" })

map("t", "<esc><esc>", [[<C-\><C-n>]], { desc = "Выйти из режима терминала" })

-- Привычные сочетания macOS. Ghostty шлёт: Option+←/→ = Alt+b/f, Cmd+←/→ = Ctrl+A/E,
-- Option+Backspace = Alt+Backspace, Cmd+Backspace = Ctrl+U (в Insert уже стирает до начала строки).
-- Без этого Cmd+← увеличивал бы число под курсором, а Option+→ ждал бы символ для поиска.
local function line_start()
  return vim.wo.wrap and "g^" or "^" -- в Markdown с переносом — начало видимой строки, как в macOS
end
local function line_end()
  return vim.wo.wrap and "g$" or "$"
end
map({ "n", "x", "o" }, "<M-b>", "b", { desc = "Слово назад (Option+←)" })
map({ "n", "x", "o" }, "<M-f>", "e", { desc = "Слово вперёд (Option+→)" })
map({ "n", "x", "o" }, "<C-a>", line_start, { expr = true, desc = "Начало строки (Cmd+←)" })
map({ "n", "x", "o" }, "<C-e>", line_end, { expr = true, desc = "Конец строки (Cmd+→)" })
map({ "i", "c" }, "<M-b>", "<S-Left>", { desc = "Слово назад (Option+←)" })
map({ "i", "c" }, "<M-f>", "<S-Right>", { desc = "Слово вперёд (Option+→)" })
map({ "i", "c" }, "<C-a>", "<Home>", { desc = "Начало строки (Cmd+←)" })
map({ "i", "c" }, "<C-e>", "<End>", { desc = "Конец строки (Cmd+→)" })
map({ "i", "c" }, "<M-BS>", "<C-w>", { desc = "Стереть слово (Option+Backspace)" })

-- Все worktree, где агенты что-то меняли: Enter — перейти туда (дерево файлов).
map("n", "<leader>fa", function()
  require("kirill.places").pick()
end, { desc = "Места агентов (worktree)" })

-- Git: короткое меню с понятными подписями вместо полного набора LazyVim.
for _, lhs in ipairs({ "<leader>gG", "<leader>gL", "<leader>gl", "<leader>gB", "<leader>gY" }) do
  pcall(vim.keymap.del, "n", lhs)
  pcall(vim.keymap.del, "x", lhs)
end
map("n", "<leader>gg", function()
  Snacks.lazygit({ cwd = LazyVim.root.git() })
end, { desc = "lazygit: коммит, push, ветки" })
map("n", "<leader>gf", function()
  Snacks.picker.git_log_file()
end, { desc = "История этого файла" })
map("n", "<leader>gb", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Кто и когда менял строку" })

-- Диагностика не показывается нигде (plugins/quiet.lua), поэтому и прыжки по ней не нужны.
-- Space u d включает её вместе с тем, что LSP успел прислать, пока она была выключена.
for _, lhs in ipairs({ "<leader>cd", "]d", "[d", "]e", "[e", "]w", "[w" }) do
  pcall(vim.keymap.del, "n", lhs)
end
require("kirill.quiet").toggle():map("<leader>ud")
