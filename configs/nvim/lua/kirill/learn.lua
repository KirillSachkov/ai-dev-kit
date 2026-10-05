-- Курс «nvim для чтения и review»: уроки лежат в learn/lessons, упражнения делаются в песочнице
-- (учебный git-проект с worktree «агента»), которую :Learn reset собирает заново.
local M = {}

local src = vim.fn.stdpath("config") .. "/learn"
local root = vim.fn.stdpath("data") .. "/learn"
local sandbox = root .. "/sandbox"
local progress = vim.fn.stdpath("state") .. "/learn-progress"

local function lessons()
  local files = vim.fn.globpath(src .. "/lessons", "*.md", false, true)
  table.sort(files, function(a, b)
    return tonumber(vim.fn.fnamemodify(a, ":t"):match("^(%d+)")) < tonumber(vim.fn.fnamemodify(b, ":t"):match("^(%d+)"))
  end)
  return files
end

local function title(file)
  local first = vim.fn.readfile(file, "", 1)[1] or ""
  return (first:gsub("^#%s*", ""))
end

local function last()
  local ok, lines = pcall(vim.fn.readfile, progress)
  return ok and tonumber(lines[1]) or nil
end

local function build(reset)
  if reset then
    assert(root:match("/learn$"), "unexpected sandbox path")
    vim.fn.delete(root, "rf")
  end
  if vim.uv.fs_stat(sandbox .. "/.git") then
    return true
  end
  vim.notify("Собираю учебную песочницу…")
  local r = vim.system({ "bash", src .. "/setup.sh", root }, { text = true }):wait()
  if r.code ~= 0 then
    vim.notify("Не удалось собрать песочницу:\n" .. (r.stderr or ""), vim.log.levels.ERROR)
    return false
  end
  return true
end

-- Курс живёт в своей вкладке nvim с рабочей папкой песочницы.
local function learn_tab()
  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
    if vim.t[tab].kirill_learn then
      vim.api.nvim_set_current_tabpage(tab)
      return
    end
  end
  vim.cmd.tabnew()
  vim.t.kirill_learn = true
  vim.cmd.tcd(vim.fn.fnameescape(sandbox))
end

function M.open(n)
  local files = lessons()
  n = math.max(0, math.min(n, #files - 1))
  if not build(false) then
    return
  end
  vim.fn.writefile({ tostring(n) }, progress)
  local target = sandbox .. "/lessons/" .. vim.fn.fnamemodify(files[n + 1], ":t")
  local buf = vim.fn.bufnr(target)
  if buf == -1 or not vim.bo[buf].modified then
    vim.fn.writefile(vim.fn.readfile(files[n + 1], "b"), target, "b") -- свежая версия урока
  end
  learn_tab()
  vim.cmd.edit(vim.fn.fnameescape(target))
end

function M.pick()
  local files, cur = lessons(), last()
  local items = {}
  for i, file in ipairs(files) do
    items[i] = { n = i - 1, text = title(file) }
  end
  vim.ui.select(items, {
    prompt = "Курс nvim" .. (cur and ("  ·  ты на уроке " .. cur) or ""),
    format_item = function(item)
      return (item.n == cur and "● " or "  ") .. item.text
    end,
  }, function(item)
    if item then
      M.open(item.n)
    end
  end)
end

function M.command(arg)
  arg = vim.trim(arg or "")
  local cur = last()
  if arg == "" then
    M.pick()
  elseif arg == "next" then
    M.open((cur or -1) + 1)
  elseif arg == "prev" then
    M.open((cur or 1) - 1)
  elseif arg == "reset" then
    -- Открытые файлы песочницы закрываем без вопросов: она и нужна, чтобы ломать.
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_get_name(buf):sub(1, #root + 1) == root .. "/" then
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end
    end
    if build(true) then
      vim.notify("Песочница собрана заново")
      M.open(cur or 0)
    end
  elseif tonumber(arg) then
    M.open(tonumber(arg))
  else
    vim.notify("Использование: :Learn [next|prev|reset|номер]", vim.log.levels.WARN)
  end
end

function M.setup()
  vim.api.nvim_create_user_command("Learn", function(opts)
    M.command(opts.args)
  end, {
    nargs = "?",
    desc = "Курс nvim: уроки в учебной песочнице",
    complete = function()
      return { "next", "prev", "reset" }
    end,
  })
end

return M
