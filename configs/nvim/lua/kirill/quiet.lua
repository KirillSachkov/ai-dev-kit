-- Диагностика не доходит даже до vim.diagnostic: ответы LSP с ошибками и предупреждениями
-- откладываются, пока диагностика выключена. Поэтому их не видит никто — ни дерево, ни поиск,
-- ни статусная строка. Space u d включает её и сразу отдаёт отложенное.
local M = {}

local held = {} -- последний ответ по каждому серверу и файлу

local function hold(name, key_of)
  local orig = vim.lsp.diagnostic[name]
  vim.lsp.diagnostic[name] = function(err, result, ctx, ...)
    if vim.diagnostic.is_enabled() then
      return orig(err, result, ctx, ...)
    end
    local key = key_of(result, ctx)
    if key then
      held[name .. ctx.client_id .. key] = { orig, err, result, ctx }
    end
  end
end

function M.setup()
  if M.done then
    return
  end
  M.done = true
  vim.diagnostic.enable(false)
  hold("on_publish_diagnostics", function(result)
    return result and result.uri
  end)
  hold("on_diagnostic", function(_, ctx)
    return ctx.params and ctx.params.textDocument and ctx.params.textDocument.uri
  end)
end

function M.toggle()
  return Snacks.toggle({
    name = "Diagnostics",
    get = function()
      return vim.diagnostic.is_enabled()
    end,
    set = function(on)
      vim.diagnostic.enable(on)
      if on then
        local pending = held
        held = {}
        for _, h in pairs(pending) do
          if vim.lsp.get_client_by_id(h[4].client_id) then
            h[1](h[2], h[3], h[4])
          end
        end
      end
    end,
  })
end

return M
