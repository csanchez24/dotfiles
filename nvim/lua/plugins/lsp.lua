-- nvim/lua/plugins/lsp.lua
-- LSP Configuration
-- https://github.com/neovim/nvim-lspconfig

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- Mason - LSP installer
    {
      "mason-org/mason.nvim",
      cmd = "Mason",
      opts = {
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      },
    },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Additional tools
    "nanotee/sqls.nvim",
    "b0o/schemastore.nvim", -- JSON/YAML schemas

    -- Lua LSP for Neovim config
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
  },

  config = function()
    -- ========================================================================
    -- LSP Capabilities (with blink.cmp)
    -- ========================================================================
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Get capabilities from blink.cmp
    local has_blink, blink = pcall(require, "blink.cmp")
    if has_blink then
      capabilities = vim.tbl_deep_extend("force", capabilities, blink.get_lsp_capabilities())
    end

    -- ========================================================================
    -- LSP Attach autocommand
    -- ========================================================================
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
          return
        end

        -- ========================================================================
        -- Navigation keymaps
        -- ========================================================================
        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("gy", require("telescope.builtin").lsp_type_definitions, "T[y]pe Definition")

        -- ========================================================================
        -- Code actions
        -- ========================================================================
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- ========================================================================
        -- Documentation
        -- ========================================================================
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gK", vim.lsp.buf.signature_help, "Signature Documentation")

        -- ========================================================================
        -- Diagnostics
        -- ========================================================================
        map("<leader>cd", vim.diagnostic.open_float, "Line [D]iagnostics")
        -- Note: <leader>xL in Trouble handles location list
        map("[d", function()
          vim.diagnostic.jump({ count = -1, float = true })
        end, "Previous Diagnostic")
        map("]d", function()
          vim.diagnostic.jump({ count = 1, float = true })
        end, "Next Diagnostic")

        -- ========================================================================
        -- Symbols
        -- ========================================================================
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        -- ========================================================================
        -- Workspace
        -- ========================================================================
        map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
        map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
        map("<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[W]orkspace [L]ist Folders")

        -- ========================================================================
        -- Inlay hints (if supported)
        -- ========================================================================
        if client:supports_method("textDocument/inlayHint") then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "[T]oggle Inlay [H]ints")
        end

        -- ========================================================================
        -- Document highlight (if supported)
        -- ========================================================================
        if client:supports_method("textDocument/documentHighlight") then
          local highlight_augroup = vim.api.nvim_create_augroup("lsp_highlight", { clear = false })

          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("lsp_detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "lsp_highlight", buffer = event2.buf })
            end,
          })
        end

        -- ========================================================================
        -- TypeScript specific
        -- ========================================================================
        if client.name == "ts_ls" then
          map("<leader>co", function()
            vim.lsp.buf.execute_command({
              command = "_typescript.organizeImports",
              arguments = { vim.api.nvim_buf_get_name(0) },
            })
          end, "[O]rganize [I]mports")
        end
      end,
    })

    -- ========================================================================
    -- Diagnostic configuration
    -- ========================================================================
    vim.diagnostic.config({
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = " ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    vim.api.nvim_create_user_command("LspInfo", function()
      vim.cmd.checkhealth("vim.lsp")
    end, { desc = "Show LSP health and attached clients" })

    vim.api.nvim_create_user_command("LspStart", function(opts)
      if opts.args ~= "" then
        vim.lsp.enable(opts.args)
      end
    end, {
      desc = "Enable an LSP client by name",
      nargs = "?",
      complete = function()
        return vim.tbl_keys(vim.lsp.config._configs or {})
      end,
    })

    vim.api.nvim_create_user_command("LspStop", function(opts)
      local name = opts.args ~= "" and opts.args or nil
      for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
        client:stop()
      end
    end, {
      desc = "Stop active LSP clients",
      nargs = "?",
      complete = function()
        local names = {}
        for _, client in ipairs(vim.lsp.get_clients()) do
          names[client.name] = true
        end
        return vim.tbl_keys(names)
      end,
    })

    vim.api.nvim_create_user_command("LspRestart", function(opts)
      local name = opts.args ~= "" and opts.args or nil
      for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
        client:stop()
        vim.lsp.enable(client.name)
      end
    end, {
      desc = "Restart active LSP clients",
      nargs = "?",
      complete = function()
        local names = {}
        for _, client in ipairs(vim.lsp.get_clients()) do
          names[client.name] = true
        end
        return vim.tbl_keys(names)
      end,
    })

    -- ========================================================================
    -- Server configurations
    -- ========================================================================
    local servers = {
      -- Lua
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = {
                "${3rd}/luv/library",
                unpack(vim.api.nvim_get_runtime_file("", true)),
              },
            },
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              disable = { "missing-fields" },
              globals = { "vim" },
            },
            format = {
              enable = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },

      -- JavaScript/TypeScript
      ts_ls = {
        settings = {
          typescript = {
            format = { enable = false },
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            format = { enable = false },
          },
        },
      },

      -- HTML
      html = {
        filetypes = { "html", "templ", "blade" },
      },

      -- CSS
      cssls = {
        settings = {
          css = { validate = true, lint = { unknownAtRules = "ignore" } },
          scss = { validate = true, lint = { unknownAtRules = "ignore" } },
          less = { validate = true, lint = { unknownAtRules = "ignore" } },
        },
      },

      -- Tailwind
      tailwindcss = {
        filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
      },

      -- JSON
      jsonls = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },

      -- YAML
      yamlls = {
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
            keyOrdering = false,
          },
        },
      },

      -- Python
      basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      },

      -- Go
      gopls = {
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
            semanticTokens = true,
          },
        },
      },

      -- PHP
      intelephense = {},

      -- ASTRO
      astro = {},

      -- SQL
      sqls = {
        root_markers = { ".sqls.yml", ".sqls.yaml", "sqls.yml", "sqls.yaml" },
        single_file_support = false,
      },
    }

    -- ========================================================================
    -- Setup servers with Mason
    -- ========================================================================
    local ensure_lsp_installed = vim.tbl_keys(servers or {})
    local ensure_tools_installed = {
      "prettier",
      "stylua", -- Lua formatter
      "shfmt", -- Shell formatter
      "ruff", -- Python formatter/import organizer
      "goimports", -- Go import organizer
      "sqlfluff", -- SQL formatter/linter
      "taplo", -- TOML formatter
      "blade-formatter",
      "phpcs",
      "phpcbf",
    }

    require("mason-tool-installer").setup({ ensure_installed = ensure_tools_installed })

    for server_name, server in pairs(servers) do
      server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
      vim.lsp.config(server_name, server)
    end

    require("mason-lspconfig").setup({
      ensure_installed = ensure_lsp_installed,
      automatic_enable = vim.tbl_filter(function(server_name)
        return server_name ~= "sqls"
      end, ensure_lsp_installed),
    })
  end,
}
