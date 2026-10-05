local M = {}

-- Шпаргалка во всплывающем окне поверх текущего; q или Esc закрывают.
function M.open()
  Snacks.win({
    file = vim.fn.stdpath("config") .. "/CHEATSHEET.md",
    width = 0.8,
    height = 0.9,
    border = "rounded",
    title = " Шпаргалка ",
    title_pos = "center",
    wo = { wrap = true, linebreak = true, conceallevel = 2, spell = false, number = false, signcolumn = "no" },
    bo = { modifiable = false, readonly = true },
    keys = { q = "close", ["<esc>"] = "close" },
  })
end

return M
