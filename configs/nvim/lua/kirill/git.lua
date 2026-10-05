-- Review веток и worktree. Сам diff рисует codediff.nvim; здесь только выбор «с чем сравнивать».
local M = {}

local function git(args, cwd)
  local r = vim.system(vim.list_extend({ "git" }, args), { cwd = cwd or vim.uv.cwd(), text = true }):wait()
  if r.code ~= 0 then
    return nil
  end
  return vim.trim(r.stdout)
end

local function root(cwd)
  return git({ "rev-parse", "--show-toplevel" }, cwd)
end

-- Ветка, от которой ответвилась текущая. Берём кандидата с самой свежей общей точкой:
-- агент мог отрезать worktree и от локального main, и от origin/main.
function M.base(cwd)
  local current = git({ "branch", "--show-current" }, cwd)
  local best, best_count
  for _, ref in ipairs({ "main", "master", "dev", "develop", "origin/main", "origin/master", "origin/dev" }) do
    if ref ~= current and git({ "rev-parse", "--verify", "--quiet", ref .. "^{commit}" }, cwd) then
      local mb = git({ "merge-base", ref, "HEAD" }, cwd)
      local count = mb and tonumber(git({ "rev-list", "--count", mb .. "..HEAD" }, cwd))
      if count and (not best_count or count < best_count) then
        best, best_count = ref, count
      end
    end
  end
  return best, best_count
end

local function codediff(args, cwd)
  local repo = root(cwd)
  if not repo then
    vim.notify("Здесь нет git-репозитория", vim.log.levels.WARN)
    return
  end
  vim.cmd("CodeDiff --repo " .. vim.fn.fnameescape(repo) .. (args ~= "" and (" " .. args) or ""))
end

-- Что не закоммичено (включая новые файлы).
function M.changes(cwd)
  codediff("", cwd)
end

-- Вся ветка как Pull Request: от точки ответвления до текущего состояния.
function M.branch(cwd)
  local base, ahead = M.base(cwd)
  if not base or ahead == 0 then
    vim.notify("Нет коммитов поверх main — показываю незакоммиченное")
    return M.changes(cwd)
  end
  vim.notify(("Ветка против %s: %d коммит(ов)"):format(base, ahead))
  codediff(base .. "...", cwd)
end

-- История коммитов текущей ветки с diff каждого.
function M.history(cwd)
  local base = M.base(cwd)
  codediff(base and ("history " .. base .. "..HEAD") or "history", cwd)
end

local function worktrees()
  local out = git({ "worktree", "list", "--porcelain" })
  if not out then
    return {}
  end
  local items, cur = {}, nil
  for line in (out .. "\n\n"):gmatch("(.-)\n") do
    local path = line:match("^worktree (.+)")
    if path then
      cur = { path = path, text = path, file = path }
    elseif cur and line:match("^branch ") then
      cur.branch = line:match("^branch refs/heads/(.+)") or line:sub(8)
    elseif cur and line == "detached" then
      cur.branch = "(detached)"
    elseif cur and line == "" then
      local dirty = git({ "status", "--porcelain" }, cur.path)
      local n = dirty and dirty ~= "" and #vim.split(dirty, "\n") or 0
      cur.dirty = n
      cur.text = (cur.branch or "") .. " " .. cur.path
      items[#items + 1] = cur
      cur = nil
    end
  end
  return items
end

-- Список worktree репозитория. Enter — review ветки этого worktree,
-- Ctrl+O — открыть его как проект (дерево + поиск) в новой вкладке.
function M.pick_worktree()
  local items = worktrees()
  if #items == 0 then
    return vim.notify("Здесь нет git worktree", vim.log.levels.WARN)
  end
  local home = vim.env.HOME
  Snacks.picker({
    title = "Worktrees",
    items = items,
    layout = { preset = "select" },
    format = function(item)
      local ret = {}
      ret[#ret + 1] = { item.branch or "?", "SnacksPickerGitBranch" }
      ret[#ret + 1] = { "  " }
      if item.dirty > 0 then
        ret[#ret + 1] = { ("● %d "):format(item.dirty), "DiagnosticWarn" }
      end
      ret[#ret + 1] = { (item.path:gsub("^" .. vim.pesc(home), "~")), "SnacksPickerDir" }
      return ret
    end,
    confirm = function(picker, item)
      picker:close()
      if item then
        M.branch(item.path)
      end
    end,
    actions = {
      open_project = function(picker, item)
        picker:close()
        if item then
          vim.cmd.tabnew()
          vim.cmd.tcd(vim.fn.fnameescape(item.path))
          Snacks.explorer({ cwd = item.path })
        end
      end,
    },
    win = {
      input = {
        keys = { ["<c-o>"] = { "open_project", mode = { "n", "i" }, desc = "Открыть как проект" } },
      },
    },
  })
end

return M
