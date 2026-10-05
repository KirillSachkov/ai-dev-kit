-- Точка входа. Всё содержательное живёт в lua/config, lua/plugins и lua/kirill.
require("config.lazy")
require("kirill.layout").setup()
require("kirill.learn").setup()

-- herdr открывает nvim без файла: Ctrl+B F — сразу дерево, Ctrl+B Shift+F — места агентов.
local start = vim.env.KIRILL_NVIM_START
vim.env.KIRILL_NVIM_START = nil -- не наследуется вложенными процессами
if start == "files" or start == "review" or start == "places" then
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    once = true,
    callback = function()
      if start == "files" then
        Snacks.explorer()
      elseif start == "places" then
        require("kirill.places").pick()
      else
        require("kirill.git").branch()
      end
    end,
  })
end
