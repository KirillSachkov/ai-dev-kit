-- Git: diff как в VS Code (codediff). Пометки на полях — gitsigns, операции — lazygit (Space g g):
-- оба уже входят в LazyVim.
local function g(fn)
  return function()
    require("kirill.git")[fn]()
  end
end

return {
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    init = function()
      local md = require("kirill.diffmd")
      local group = vim.api.nvim_create_augroup("kirill_codediff", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = { "CodeDiffOpen", "CodeDiffFileSelect" },
        callback = function(ev)
          local tab = ev.data and ev.data.tabpage or vim.api.nvim_get_current_tabpage()
          md.on_review(tab)
          vim.defer_fn(function()
            md.on_review(tab) -- буферы файла могли подгрузиться чуть позже события
          end, 200)
        end,
      })
      vim.api.nvim_create_autocmd("User", { group = group, pattern = "CodeDiffClose", callback = md.on_close })
    end,
    opts = {
      diff = {
        layout = "inline", -- одна колонка: удалённое и добавленное в одном тексте; t — две колонки
        gutter_signs = true,
        compact_context_lines = 4,
        cycle_hunks_across_files = true, -- ]c на последнем изменении файла переходит в следующий файл
      },
      explorer = {
        position = "left",
        width = 40,
        view_mode = "tree",
        line_stats = { enabled = true, count_untracked = true },
      },
      history = { position = "bottom", height = 14, view_mode = "tree" },
    },
    keys = {
      { "<leader>gd", g("changes"), desc = "Что изменилось (не закоммичено)" },
      { "<leader>gr", g("branch"), desc = "Review ветки как PR" },
      { "<leader>gH", g("history"), desc = "Коммиты ветки с diff" },
      { "<leader>gw", g("pick_worktree"), desc = "Worktrees → review" },
    },
  },
}
