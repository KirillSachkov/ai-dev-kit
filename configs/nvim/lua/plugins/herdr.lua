-- herdr: комментарии к строкам кода уходят агенту из той же вкладки (Space a …).
-- Счётчик «● 3» в статусной строке — в lua/plugins/minimal.lua.
return {
  {
    "ChmaraX/herdr-nvim",
    cond = vim.env.HERDR_ENV == "1", -- вне herdr плагин не нужен
    opts = { prefix = "<leader>a", keymaps = true, clear_after_send = true },
  },
}
