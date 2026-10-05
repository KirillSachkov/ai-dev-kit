-- Места агентов: все worktree, где агенты что-то меняли за последние дни, и где работают сейчас.
-- Данные даёт трекер herdr (herdr-agent-context list): он записывает каждую правку агента.
local M = {}

local function tracker()
  local bin = vim.fn.exepath("herdr-agent-context")
  return bin ~= "" and bin or vim.fn.expand("~/.local/bin/herdr-agent-context")
end

local function load(days)
  local r = vim.system({ tracker(), "list", "--json", "--days", tostring(days) }, { text = true }):wait()
  if r.code ~= 0 then
    return nil, vim.trim(r.stderr ~= "" and r.stderr or r.stdout)
  end
  local ok, places = pcall(vim.json.decode, r.stdout, { luanil = { object = true, array = true } })
  return ok and places or nil, "не удалось разобрать ответ трекера"
end

-- ISO-время трекера (UTC) → «5 мин», «3 ч», «2 дн».
local utc_offset = os.time() - os.time(os.date("!*t"))
local function ago(iso)
  local y, mo, d, h, mi, s = tostring(iso or ""):match("(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)")
  if not y then
    return ""
  end
  local t = os.time({ year = y, month = mo, day = d, hour = h, min = mi, sec = s }) + utc_offset
  local dt = math.max(0, os.time() - t)
  if dt < 3600 then
    return ("%d мин"):format(math.max(1, math.floor(dt / 60)))
  elseif dt < 86400 then
    return ("%d ч"):format(math.floor(dt / 3600))
  end
  return ("%d дн"):format(math.floor(dt / 86400))
end

-- «claude ×3 · codex»: сколько сессий каждого агента трогали это место.
local function agents_summary(agents)
  local order, count = {}, {}
  for _, a in ipairs(agents) do
    if not count[a.agent] then
      order[#order + 1] = a.agent
    end
    count[a.agent] = (count[a.agent] or 0) + 1
  end
  return table.concat(
    vim.tbl_map(function(name)
      return count[name] > 1 and ("%s ×%d"):format(name, count[name]) or name
    end, order),
    " · "
  )
end

local function git_lines(path, args)
  local r = vim.system(vim.list_extend({ "git", "-C", path }, args), { text = true }):wait()
  return r.code == 0 and vim.split(vim.trim(r.stdout), "\n") or {}
end

local function preview_text(item)
  local lines = { item.path, "" }
  local past = {}
  for _, a in ipairs(item.agents) do
    if a.current then
      local state = a.status == "working" and "работает здесь" or "сейчас здесь"
      local title = a.title ~= "" and (" — " .. a.title) or ""
      lines[#lines + 1] = ("%s: %s%s"):format(a.agent, state, title)
    else
      past[#past + 1] = a
    end
  end
  if #past > 0 then
    lines[#lines + 1] = "раньше здесь правили: " .. agents_summary(past)
  end
  if item.last_write_at then
    lines[#lines + 1] = ("последняя правка: %s назад · правок: %d"):format(ago(item.last_write_at), item.writes)
  end
  lines[#lines + 1] = ""
  vim.list_extend(lines, git_lines(item.path, { "status", "-sb" }))
  local stat = git_lines(item.path, { "diff", "--stat", "HEAD" })
  if #stat > 0 and stat[1] ~= "" then
    lines[#lines + 1] = ""
    vim.list_extend(lines, stat)
  end
  lines[#lines + 1] = ""
  vim.list_extend(lines, git_lines(item.path, { "log", "--oneline", "-8" }))
  return table.concat(lines, "\n")
end

-- Переключить текущую вкладку nvim на место: cwd вкладки, дерево файлов от его корня.
local function open_here(path)
  vim.cmd.tcd(vim.fn.fnameescape(path))
  for _, picker in ipairs(Snacks.picker.get({ source = "explorer" })) do
    picker:close()
  end
  Snacks.explorer({ cwd = path })
end

function M.pick(opts)
  opts = opts or {}
  local places, err = load(opts.days or 14)
  if not places then
    return vim.notify("Трекер агентов: " .. (err or "?"), vim.log.levels.ERROR)
  end
  if #places == 0 then
    return vim.notify("Агенты ничего не меняли за последние дни", vim.log.levels.WARN)
  end
  local home = vim.env.HOME
  local items = {}
  for _, p in ipairs(places) do
    p.short = p.path:gsub("^" .. vim.pesc(home), "~")
    p.who = agents_summary(p.agents)
    p.text = table.concat({ p.repo, p.branch or "", p.short, p.who }, " ")
    p.file = p.path
    items[#items + 1] = p
  end
  Snacks.picker({
    title = "Места агентов",
    items = items,
    layout = { preset = "default" },
    format = function(item)
      local ret = {}
      ret[#ret + 1] = item.current and { "▶ ", "DiagnosticOk" } or { "  " }
      ret[#ret + 1] = { item.repo, "SnacksPickerDirectory" }
      ret[#ret + 1] = { "  " }
      ret[#ret + 1] = { item.branch or "(detached)", "SnacksPickerGitBranch" }
      if item.dirty > 0 then
        ret[#ret + 1] = { ("  ● %d"):format(item.dirty), "DiagnosticWarn" }
      end
      ret[#ret + 1] = { "  " .. item.who, "SnacksPickerComment" }
      local when = ago(item.last_activity_at)
      if when ~= "" then
        ret[#ret + 1] = { "  " .. when, "SnacksPickerComment" }
      end
      ret[#ret + 1] = { "  " .. item.short, "SnacksPickerDir" }
      return ret
    end,
    preview = function(ctx)
      ctx.item.preview = ctx.item.preview or { text = preview_text(ctx.item), ft = "git", loc = false }
      return require("snacks.picker.preview").preview(ctx)
    end,
    confirm = function(picker, item)
      picker:close()
      if item then
        open_here(item.path)
      end
    end,
    actions = {
      place_tab = function(picker, item)
        picker:close()
        if item then
          vim.cmd.tabnew()
          open_here(item.path)
        end
      end,
      place_review = function(picker, item)
        picker:close()
        if item then
          vim.cmd.tcd(vim.fn.fnameescape(item.path))
          require("kirill.git").branch(item.path)
        end
      end,
      place_changes = function(picker, item)
        picker:close()
        if item then
          vim.cmd.tcd(vim.fn.fnameescape(item.path))
          require("kirill.git").changes(item.path)
        end
      end,
    },
    win = {
      input = {
        keys = {
          ["<c-t>"] = { "place_tab", mode = { "n", "i" }, desc = "Открыть в новой вкладке" },
          ["<c-r>"] = { "place_review", mode = { "n", "i" }, desc = "Review ветки как PR" },
          ["<c-e>"] = { "place_changes", mode = { "n", "i" }, desc = "Что не закоммичено" },
        },
      },
    },
  })
end

return M
