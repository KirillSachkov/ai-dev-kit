local group = vim.api.nvim_create_augroup("kirill", { clear = true })

-- Текст и Markdown: мягкий перенос по словам, без автоформатирования.
local prose = { "markdown", "text", "gitcommit" }
local function as_document()
  if vim.t.kirill_review then
    return -- в review перенос сбивает выравнивание половин diff
  end
  vim.opt_local.wrap = true
  vim.opt_local.spell = false
  vim.opt_local.colorcolumn = ""
  -- Документ, а не код: без номеров строк и направляющих отступов (Space u l вернёт номера).
  vim.opt_local.number = false
  vim.opt_local.signcolumn = "auto"
  vim.b.snacks_indent = false
end
vim.api.nvim_create_autocmd("FileType", { group = group, pattern = prose, callback = as_document })
-- Этот файл LazyVim грузит лениво: окна, открытые раньше него (например, :Learn при старте), догоняем.
for _, win in ipairs(vim.api.nvim_list_wins()) do
  if vim.tbl_contains(prose, vim.bo[vim.api.nvim_win_get_buf(win)].filetype) then
    vim.api.nvim_win_call(win, as_document)
  end
end

-- Агент правит файлы, пока ты читаешь: подтягиваем изменения и без переключения фокуса.
vim.api.nvim_create_autocmd({ "CursorHold", "BufEnter" }, {
  group = group,
  callback = function()
    if vim.fn.mode() ~= "c" and vim.bo.buftype == "" then
      vim.cmd("silent! checktime")
    end
  end,
})
