-- Внутри review (codediff) Markdown показываем исходником и без переноса строк: иначе половины
-- diff разъезжаются. render-markdown сам молчит только в окнах 'diff', а codediff их так не
-- помечает. События приходят в любом порядке, поэтому ловим оба: открытие review и attach.
local M = {}
local plain = {}

local function in_review(buf)
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    if vim.t[vim.api.nvim_win_get_tabpage(win)].kirill_review then
      return true
    end
  end
  return false
end

local function render(buf, enable)
  if package.loaded["render-markdown"] and vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_buf_call(buf, function()
      require("render-markdown").set_buf(enable)
    end)
  end
end

local function make_plain(buf)
  plain[buf] = true
  render(buf, false)
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    if vim.t[vim.api.nvim_win_get_tabpage(win)].kirill_review then
      vim.wo[win].wrap = false
    end
  end
end

-- render-markdown: on.attach
function M.on_attach(buf)
  vim.schedule(function()
    if in_review(buf) then
      make_plain(buf)
    end
  end)
end

-- codediff: CodeDiffOpen / CodeDiffFileSelect
function M.on_review(tab)
  if not vim.api.nvim_tabpage_is_valid(tab) then
    return
  end
  vim.t[tab].kirill_review = true
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "markdown" then
      make_plain(buf)
    end
  end
end

-- codediff: CodeDiffClose
function M.on_close()
  for buf in pairs(plain) do
    render(buf, true)
  end
  plain = {}
end

return M
