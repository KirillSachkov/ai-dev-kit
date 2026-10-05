-- Загружается до плагинов. Дефолты LazyVim: https://www.lazyvim.org/configuration/general
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.lazyvim_picker = "snacks"
vim.g.lazyvim_cmp = "blink.cmp"
vim.g.autoformat = false -- чтение и review не должны менять файлы при сохранении
vim.g.snacks_animate = false -- без анимаций: ничего не «плывёт» при прокрутке
vim.g.lazyvim_check_order = false

local o = vim.opt
o.mouse = "a" -- мышь работает везде: клик, прокрутка, выделение, ресайз окон
o.clipboard = "unnamedplus" -- y/p ходят через системный буфер macOS
o.number = true
o.relativenumber = false -- обычные номера строк, как в любом редакторе
o.cursorline = true
o.signcolumn = "yes"
o.wrap = false
o.linebreak = true
o.breakindent = true
o.showbreak = "↪ "
o.scrolloff = 8
o.sidescrolloff = 8
o.smoothscroll = true
o.undofile = true
o.swapfile = false -- агенты правят те же файлы: swap-предупреждения только мешают
o.autoread = true -- изменения агента подтягиваются в открытые буферы
o.confirm = true
o.updatetime = 200
o.timeoutlen = 400
o.splitright = true
o.splitbelow = true
o.splitkeep = "screen"
o.ignorecase = true
o.smartcase = true
o.laststatus = 3
o.winborder = "rounded"
o.conceallevel = 2
o.spelllang = { "ru_yo", "en_us" }
o.spelloptions = "camel"
o.diffopt:append({ "algorithm:histogram", "indent-heuristic", "linematch:60" })

-- Русская раскладка: встроенные команды понимают русские буквы (й = q, ц = w, … я = z).
-- Остальные слои — в lua/kirill/layout.lua.
o.langmap = require("kirill.layout").langmap()
