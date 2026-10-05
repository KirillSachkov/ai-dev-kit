-- Минимум: просмотр файлов, поиск и git. Всё, что помогает писать код (дополнение, сниппеты,
-- автоскобки, форматирование, списки проблем), выключено. Маленькие правки по-прежнему работают:
-- это обычный vim, просто без подсказок.
local function off(name)
  return { name, enabled = false }
end

return {
  off("saghen/blink.cmp"),
  off("rafamadriz/friendly-snippets"),
  off("nvim-mini/mini.pairs"),
  off("nvim-mini/mini.ai"),
  off("windwp/nvim-ts-autotag"),
  off("folke/ts-comments.nvim"),
  off("stevearc/conform.nvim"),
  off("folke/todo-comments.nvim"),
  off("folke/trouble.nvim"),
  off("MagicDuck/grug-far.nvim"),
  off("linux-cafe/venv-selector.nvim"),
  off("folke/lazydev.nvim"),
  -- Открытые файлы — Space , (список), Shift+H / Shift+L (по очереди). Полоса вкладок не нужна.
  off("akinsho/bufferline.nvim"),

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = { enabled = false }, -- только линтер и форматтер Python: для чтения ничего не даёт
      },
    },
  },

  -- noice: без спиннеров «LSP загружается» и без всплывающих подсказок аргументов при вводе.
  {
    "folke/noice.nvim",
    opts = {
      lsp = { progress = { enabled = false }, signature = { enabled = false } },
    },
  },

  -- Статусная строка: режим, ветка, файл, правки файла, позиция. Без часов, диагностики и служебного.
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local icons = LazyVim.config.icons
      opts.options.section_separators = { left = "", right = "" }
      opts.options.component_separators = { left = "", right = "" }
      opts.sections = {
        lualine_a = { "mode" },
        lualine_b = { { "branch", icon = "" } },
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { LazyVim.lualine.pretty_path() },
        },
        lualine_x = {
          {
            -- herdr: «● 3» — сколько комментариев ждут отправки агенту.
            function()
              local ok, herdr = pcall(require, "herdr-nvim")
              return ok and herdr.statusline() or ""
            end,
            cond = function()
              return vim.env.HERDR_ENV == "1"
            end,
          },
          {
            "diff",
            symbols = { added = icons.git.added, modified = icons.git.modified, removed = icons.git.removed },
            source = function()
              local gs = vim.b.gitsigns_status_dict
              return gs and { added = gs.added, modified = gs.changed, removed = gs.removed }
            end,
          },
        },
        lualine_y = { { "location", padding = { left = 1, right = 1 } } },
        lualine_z = {},
      }
    end,
  },

  -- Git: на полях только пометки изменённых строк, ]h / [h — к следующей / предыдущей правке.
  -- Весь набор Space g h … (stage, reset, blame буфера) убран: для этого есть lazygit (Space g g).
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(buf)
        local gs = package.loaded.gitsigns
        local function map(lhs, fn, desc)
          vim.keymap.set("n", lhs, fn, { buffer = buf, desc = desc })
        end
        map("]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Следующая правка")
        map("[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Предыдущая правка")
      end,
    },
  },

  -- Меню Space g: только то, что есть в шпаргалке. GitHub issues/PR, stash, второй lazygit и
  -- второй log убраны, чтобы не путаться.
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>gD", false },
      { "<leader>gS", false },
      { "<leader>gi", false },
      { "<leader>gI", false },
      { "<leader>gp", false },
      { "<leader>gP", false },
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Изменённые файлы (список)",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = { { "<leader>gh", hidden = true } },
    },
  },
}
