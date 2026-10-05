-- Чтение: Markdown прямо в буфере, картинки и PDF в терминале, CSV таблицей.
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      render_modes = { "n", "c", "t" }, -- в Insert весь файл исходником: видно, что правишь
      anti_conceal = { enabled = false }, -- при чтении разметка не проступает под курсором
      heading = {
        sign = false,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " }, -- вместо # — значок уровня
        width = { "full", "full", "block" }, -- H1 и H2 — полоса на всю ширину, ниже — по тексту
        right_pad = 2,
        border = { true, false }, -- у H1 тонкие линии сверху и снизу
        border_virtual = true,
      },
      code = { sign = false, width = "block", left_pad = 2, right_pad = 2, min_width = 60, border = "thin" },
      pipe_table = { preset = "round" },
      checkbox = { enabled = true },
      on = {
        attach = function(ctx)
          require("kirill.diffmd").on_attach(ctx.buf)
        end,
      },
    },
  },
  -- Markdownlint и оглавление-форматтер из extra шумят при чтении: выключены.
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = { linters_by_ft = { markdown = {}, ["markdown.mdx"] = {} } },
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = vim.tbl_filter(function(name)
        return name ~= "markdownlint-cli2" and name ~= "markdown-toc"
      end, opts.ensure_installed or {})
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        enabled = true,
        doc = { inline = true, float = true, max_width = 80, max_height = 30 },
      },
    },
  },
  {
    "hat0uma/csvview.nvim",
    ft = { "csv", "tsv" },
    opts = {
      parser = { comments = { "#", "//" } },
      view = { display_mode = "border", header_lnum = 1, sticky_header = { enabled = true } },
      keymaps = {
        textobject_field_inner = { "if", mode = { "o", "x" } },
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
      },
    },
    config = function(_, opts)
      require("csvview").setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "csv", "tsv" },
        callback = function(ev)
          require("csvview").enable(ev.buf)
        end,
      })
      if vim.tbl_contains({ "csv", "tsv" }, vim.bo.filetype) then
        require("csvview").enable(0)
      end
    end,
  },
}
