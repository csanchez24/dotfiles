-- nvim/lua/plugins/telescope.lua
-- Fuzzy finder
-- https://github.com/nvim-telescope/telescope.nvim

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false, -- Use latest
  dependencies = {
    "nvim-lua/plenary.nvim",

    -- FZF native (MUCHO más rápido)
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },

    -- UI select with telescope
    "nvim-telescope/telescope-ui-select.nvim",

    -- File browser
    {
      "nvim-telescope/telescope-file-browser.nvim",
      enabled = true,
    },

    -- Icons
    "nvim-tree/nvim-web-devicons",
  },

  keys = {
    -- Files
    {
      "<leader><space>",
      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Buffers",
    },
    { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },

    -- Search
    { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
    { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Word" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks" },
    { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume" },

    -- Git
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },

    -- LSP
    { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    { "<leader>sS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },

    -- File browser
    { "<leader>sE", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
    {
      "<leader>se",
      "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
      desc = "File Browser (cwd)",
    },

    -- Config
    {
      "<leader>sn",
      function()
        require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Neovim Config",
    },
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local fb_actions = require("telescope").extensions.file_browser.actions

    -- Custom action: send to qflist and open
    local function send_selected_to_qflist_and_open(prompt_bufnr)
      actions.send_selected_to_qflist(prompt_bufnr)
      vim.cmd("copen")
    end

    telescope.setup({
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        multi_icon = " ",

        -- Layout
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },

        -- Sorting
        sorting_strategy = "ascending",
        selection_strategy = "reset",
        scroll_strategy = "cycle",

        -- Appearance
        winblend = 0,
        border = true,
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },

        -- Performance
        file_ignore_patterns = {
          "%.git/",
          "node_modules/",
          "%.next/",
          "dist/",
        },

        -- Path display
        path_display = { "truncate" },

        -- Mappings
        mappings = {
          i = {
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,

            ["<C-c>"] = actions.close,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-a>"] = send_selected_to_qflist_and_open,

            ["<C-l>"] = actions.complete_tag,
            ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
          },

          n = {
            ["<esc>"] = actions.close,
            ["q"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-a>"] = send_selected_to_qflist_and_open,

            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["H"] = actions.move_to_top,
            ["M"] = actions.move_to_middle,
            ["L"] = actions.move_to_bottom,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["?"] = actions.which_key,
          },
        },
      },

      -- Picker-specific settings
      pickers = {
        find_files = {
          -- Use fd if available
          find_command = { "fd", "--type", "f", "--hidden", "--no-ignore", "--strip-cwd-prefix" },
          hidden = true,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
        buffers = {
          sort_mru = true,
          sort_lastused = true,
          mappings = {
            i = {
              ["<c-d>"] = actions.delete_buffer,
            },
            n = {
              ["dd"] = actions.delete_buffer,
            },
          },
        },
      },

      -- Extensions
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
        file_browser = {
          hidden = true,
          hijack_netrw = false,
          -- prompt_path = false,
          -- path_autocomplete = false,
          -- auto_depth = false,
          -- respect_gitignore = false,
          -- grouped = true,
          -- select_buffer = false,
          previewer = true,
          mappings = {
            ["i"] = {
              -- Crear archivo/carpeta
              ["<C-n>"] = fb_actions.create,
              -- Renombrar
              ["<C-r>"] = fb_actions.rename,
              -- Mover
              ["<C-m>"] = fb_actions.move,
              -- Copiar
              ["<C-y>"] = fb_actions.copy,
              -- Borrar
              ["<C-d>"] = fb_actions.remove,
              -- Toggle hidden
              ["<C-h>"] = fb_actions.toggle_hidden,
              -- Go to parent dir
              ["<C-u>"] = fb_actions.goto_parent_dir,
              -- Change to cwd
              ["<C-w>"] = fb_actions.goto_cwd,
              -- Change to home dir
              ["<C-e>"] = fb_actions.goto_home_dir,
              -- Toggle browser
              ["<C-f>"] = fb_actions.toggle_browser,
              -- Close
              ["<C-c>"] = actions.close,
            },
            ["n"] = {
              -- Navegación
              ["h"] = fb_actions.goto_parent_dir,
              ["l"] = actions.select_default,

              -- Crear (Insert mode para nombre)
              ["c"] = fb_actions.create,
              ["a"] = fb_actions.create,

              -- Renombrar
              ["r"] = fb_actions.rename,

              -- Mover
              ["m"] = fb_actions.move,

              -- Copiar
              ["y"] = fb_actions.copy,

              -- Borrar
              ["d"] = fb_actions.remove,

              -- Toggle hidden
              ["."] = fb_actions.toggle_hidden,

              -- Otros
              ["g"] = fb_actions.goto_cwd,
              ["e"] = fb_actions.goto_home_dir,
              ["w"] = fb_actions.goto_cwd,
              ["t"] = fb_actions.change_cwd,
              ["f"] = fb_actions.toggle_browser,

              -- Cerrar
              ["q"] = actions.close,
              ["<esc>"] = actions.close,
            },
          },
        },
      },
    })

    -- Load extensions
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")
    pcall(telescope.load_extension, "file_browser")
  end,
}
