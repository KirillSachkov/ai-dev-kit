-- Русская раскладка. Три слоя:
-- 1. Раскладка macOS (через macism): в Normal и в поиске файлов всегда английская; при вводе
--    текста и комментариев возвращается та, на которой ты печатал; при выходе из nvim или уходе
--    в другую панель — тоже она. Нажал русскую букву в Normal (переключил руками) — сразу
--    включается английская.
-- 2. langmap: встроенные команды (j, k, gg, u, dd, …) понимают русские буквы и без переключения.
-- 3. Ctrl+буква Ghostty шлёт по физической клавише (~/.config/ghostty/config).
local M = {}

local ru =
  "ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm,.~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local to_en = {}
do
  local chars = vim.fn.split(ru, "\\zs")
  for i, c in ipairs(chars) do
    to_en[c] = en:sub(i, i)
  end
end

local ABC = "com.apple.keylayout.ABC"
local typing -- раскладка, на которой ты последний раз печатал текст

local function picker()
  return vim.bo.filetype == "snacks_picker_input"
end

local function switch(id)
  vim.system({ "macism", id }, { detach = true })
end

-- Запомнить текущую раскладку как «рабочую» и включить английскую.
local function to_abc(remember)
  vim.system({ "macism" }, { text = true }, function(r)
    local cur = r.code == 0 and vim.trim(r.stdout) or nil
    if not cur then
      return
    end
    if remember then
      typing = cur
    end
    if cur ~= ABC then
      switch(ABC)
    end
  end)
end

local function restore()
  if typing then
    switch(typing)
  end
end

-- Прыжок flash (s) ждёт символы для поиска: пока он активен, русские буквы не трогаем.
local function flash_active()
  local ns = vim.api.nvim_get_namespaces()["flash"]
  return ns and #vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, { limit = 1 }) > 0
end

-- Клавиши, после которых идёт символ-аргумент (найти символ, заменить, метка, регистр).
local takes_char = { f = true, F = true, t = true, T = true, r = true, m = true, ["'"] = true, ["`"] = true }

-- Русская буква в Normal значит, что раскладку переключили руками: включаем английскую.
-- Клавишу не подменяем (nvim уже разобрал сочетание); встроенные команды выручит langmap,
-- Space-сочетание достаточно нажать ещё раз.
local function watch_keys()
  local literal_next = false
  vim.on_key(function(_, typed)
    if not typed or typed == "" then
      return
    end
    local mode = vim.api.nvim_get_mode().mode
    if not (mode:match("^n") or mode:match("^[vV\22]")) then
      literal_next = false
      return
    end
    if not to_en[typed] then
      -- f/t/r/m на английской: следующая русская буква — искомый символ, раскладку не трогаем.
      literal_next = takes_char[typed] == true and vim.fn.maparg(typed, mode:sub(1, 1)) == ""
      return
    end
    if literal_next or flash_active() then
      literal_next = false
      return
    end
    to_abc(false)
  end, vim.api.nvim_create_namespace("kirill_layout_keys"))
end

function M.langmap()
  local function esc(str)
    return (str:gsub('[;,\\"]', "\\%0"))
  end
  return esc(ru) .. ";" .. esc(en)
end

function M.setup()
  if vim.fn.executable("macism") ~= 1 then
    return
  end
  watch_keys()
  local group = vim.api.nvim_create_augroup("kirill_layout", { clear = true })
  local function on(events, fn)
    vim.api.nvim_create_autocmd(events, { group = group, callback = fn })
  end
  on({ "VimEnter", "FocusGained" }, function()
    to_abc(true) -- пришёл из агента или другой панели: запомнить, на чём ты там писал
  end)
  on("InsertLeave", function()
    to_abc(not picker())
  end)
  on("CmdlineLeave", function()
    to_abc(false)
  end)
  on("InsertEnter", function()
    if not picker() then
      restore()
    end
  end)
  on({ "FocusLost", "VimLeavePre" }, restore)
end

return M
