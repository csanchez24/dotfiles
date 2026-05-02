-- nvim/lua/plugins/formatter.lua
-- Autoformat con conform.nvim
-- https://github.com/stevearc/conform.nvim

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    notify_on_error = false,

    -- Format on save
    format_on_save = function(bufnr)
      -- Disable with global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      -- Disable for certain filetypes
      local disabled_filetypes = { "sql", "java" }
      if vim.tbl_contains(disabled_filetypes, vim.bo[bufnr].filetype) then
        return
      end

      return {
        timeout_ms = 2000,
        lsp_format = "fallback",
      }
    end,

    -- Formatters por filetype
    formatters_by_ft = {
      -- Lua
      lua = { "stylua" },

      -- Shell
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
      fish = { "fish_indent" },

      -- Web
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      less = { "prettier" },

      -- JavaScript/TypeScript
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      vue = { "prettier" },
      svelte = { "prettier" },
      astro = { "prettier" },

      -- JSON/YAML
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      toml = { "taplo" },

      -- Markdown
      markdown = { "prettier" },
      ["markdown.mdx"] = { "prettier" },

      -- GraphQL
      graphql = { "prettier" },

      -- Python
      python = { "ruff_format", "ruff_organize_imports", stop_after_first = true },

      -- Go
      go = { "goimports", "gofmt" },

      -- Rust
      rust = { "rustfmt" },

      -- PHP
      php = { "pint", "phpcbf", stop_after_first = true },

      blade = { "blade-formatter" },

      -- SQL
      sql = { "sqlfluff" },

      -- C/C++
      c = { "clang_format" },
      cpp = { "clang_format" },

      -- Use a sub-list to run ONLY the first available formatter
      -- javascript = { { "prettierd", "prettier" } },
    },

    -- Configuración de formatters específicos
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2", "-ci" },
      },
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      },
    },
  },

  init = function()
    -- Format commands
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! = buffer local
        vim.b.disable_autoformat = true
      else
        -- FormatDisable = global
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })

    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_format = "fallback", range = range })
    end, {
      desc = "Format buffer or range",
      range = true,
    })
  end,
}
