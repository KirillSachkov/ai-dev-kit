-- Внешний вид. Тема следует за macOS: днём светлая, ночью тёмная — как Ghostty и herdr.
-- Примерить другие темы вживую: Space u C (стрелки — превью, Enter — применить до перезапуска).
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "auto",
      background = { light = "latte", dark = "mocha" },
      float = { transparent = false, solid = false },
      auto_integrations = true,
    },
  },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      news = { lazyvim = false, neovim = false },
    },
  },
  {
    "folke/which-key.nvim",
    keys = { { "<leader>?", false } }, -- здесь шпаргалка; клавиши буфера — Space s k
    opts = {
      preset = "helix",
      delay = 300,
      spec = {
        { "<leader>a", group = "агент: комментарии" },
        { "<leader>f", group = "файлы" },
        { "<leader>s", group = "поиск" },
        { "<leader>g", group = "git / review" },
        { "<leader>u", group = "вид (переключатели)" },
        { "<leader>c", group = "код" },
        { "<leader>x", group = "списки" },
        { "<leader>b", group = "открытые файлы" },
        { "<leader>w", group = "окна" },
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.explorer = vim.tbl_deep_extend("force", opts.explorer or {}, { replace_netrw = true, trash = true })
      opts.picker = vim.tbl_deep_extend("force", opts.picker or {}, {
        sources = {
          explorer = {
            hidden = true, -- .github, .claude, .env.example видны сразу
            -- Как в VS Code: то, что git игнорирует (repositories/, worktrees/, node_modules),
            -- видно, но приглушено. Совсем скрыты только служебные кэши. I в дереве — переключить.
            ignored = true,
            exclude = { ".git", ".DS_Store", "__pycache__", ".pytest_cache", ".ruff_cache", ".mypy_cache" },
            -- Дерево только для файлов: значки ошибок и предупреждений не нужны. Explorer читает
            -- vim.diagnostic.get() напрямую, поэтому глобальное выключение из quiet.lua его не касается.
            diagnostics = false,
            diagnostics_open = false,
            icons = { git = { ignored = "" } }, -- игнорируемое и так приглушено
            layout = { layout = { width = 36 } },
          },
          -- Space f p: любой репозиторий или worktree как проект. Дочерние репозитории inside
          -- лежат в игнорируемой repositories/, поэтому их корень указан отдельно.
          projects = {
            dev = { "~/Projects" },
            max_depth = 3,
            patterns = { ".git" },
          },
          files = { hidden = true },
          grep = { hidden = true },
        },
      })
      -- Стартовый экран: только то, с чего реально начинаешь.
      opts.dashboard = opts.dashboard or {}
      opts.dashboard.preset = opts.dashboard.preset or {}
      opts.dashboard.preset.keys = {
        { icon = " ", key = "e", desc = "Дерево файлов", action = ":lua Snacks.explorer()" },
        { icon = " ", key = "f", desc = "Найти файл", action = ":lua Snacks.picker.files()" },
        { icon = " ", key = "/", desc = "Найти текст", action = ":lua Snacks.picker.grep()" },
        {
          icon = " ",
          key = "d",
          desc = "Что изменилось",
          action = ":lua require('kirill.git').changes()",
        },
        { icon = " ", key = "r", desc = "Review ветки как PR", action = ":lua require('kirill.git').branch()" },
        { icon = " ", key = "a", desc = "Места агентов", action = ":lua require('kirill.places').pick()" },
        { icon = " ", key = "w", desc = "Worktrees", action = ":lua require('kirill.git').pick_worktree()" },
        { icon = " ", key = "p", desc = "Проекты и worktree", action = ":lua Snacks.picker.projects()" },
        { icon = " ", key = "o", desc = "Недавние файлы", action = ":lua Snacks.picker.recent()" },
        { icon = "󰑴 ", key = "l", desc = "Курс nvim (уроки)", action = ":Learn" },
        { icon = "󰋖 ", key = "?", desc = "Шпаргалка", action = ":lua require('kirill.help').open()" },
        { icon = " ", key = "q", desc = "Выйти", action = ":qa" },
      }
    end,
  },
}
