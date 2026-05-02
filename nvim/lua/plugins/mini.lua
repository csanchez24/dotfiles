-- nvim/lua/plugins/mini.lua
-- Collection of various small independent plugins/modules
-- https://github.com/echasnovski/mini.nvim

return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",
  dependencies = {
    -- Needed for comment functionality with JSX/TSX
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      init = function()
        vim.g.skip_ts_context_commentstring_module = true
      end,
      opts = { enable_autocmd = false },
    },
  },

  config = function()
    -- ========================================================================
    -- Mini.icons - File icons (reemplaza nvim-web-devicons)
    -- ========================================================================
    require("mini.icons").setup()
    -- Compatibilidad con plugins que usan nvim-web-devicons
    MiniIcons.mock_nvim_web_devicons()

    -- ========================================================================
    -- Mini.ai - Better text objects
    -- ========================================================================
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require("mini.ai").setup({
      n_lines = 500,
      -- Custom text objects
      custom_textobjects = {
        -- Whole buffer
        e = function()
          local from = { line = 1, col = 1 }
          local to = {
            line = vim.fn.line("$"),
            col = math.max(vim.fn.getline("$"):len(), 1),
          }
          return { from = from, to = to }
        end,
      },
    })

    -- ========================================================================
    -- Mini.surround - Add/delete/replace surroundings
    -- ========================================================================
    -- Examples:
    --  - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    --  - sd'   - [S]urround [D]elete [']quotes
    --  - sr)'  - [S]urround [R]eplace [)] [']
    require("mini.surround").setup({
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    })

    -- ========================================================================
    -- Mini.pairs - Auto-close brackets
    -- ========================================================================
    require("mini.pairs").setup()

    -- ========================================================================
    -- Mini.comment - Better commenting
    -- ========================================================================
    -- Keymaps:
    --  - gcc  - toggle comment line
    --  - gc   - toggle comment selection (visual)
    --  - gcap - toggle comment paragraph
    require("mini.comment").setup({
      options = {
        -- Function to compute custom comment string
        custom_commentstring = function(ref_position)
          local ok, ts_comment = pcall(require, "ts_context_commentstring")
          if ok then
            local location = ref_position and { ref_position[1] - 1, ref_position[2] - 1 } or nil
            return ts_comment.calculate_commentstring({ location = location }) or vim.bo.commentstring
          end
          return vim.bo.commentstring
        end,
      },
    })

    -- ========================================================================
    -- Mini.statusline (OPCIONAL - si no usas lualine)
    -- ========================================================================
    -- Descomenta si quieres reemplazar lualine
    -- require('mini.statusline').setup({ use_icons = true })

    -- ========================================================================
    -- Mini.tabline (OPCIONAL - tabs minimalistas)
    -- ========================================================================
    -- Descomenta si quieres tabs
    -- require('mini.tabline').setup()

    -- ========================================================================
    -- Mini.bufremove - Better buffer deletion
    -- ========================================================================
    require("mini.bufremove").setup()

    -- Keymap para cerrar buffer sin cerrar ventana
    vim.keymap.set("n", "<leader>bd", function()
      require("mini.bufremove").delete(0, false)
    end, { desc = "Delete Buffer" })

    vim.keymap.set("n", "<leader>bD", function()
      require("mini.bufremove").delete(0, true)
    end, { desc = "Delete Buffer (Force)" })

    -- ========================================================================
    -- Mini.indentscope - Indent guides con scope
    -- ========================================================================
    require("mini.indentscope").setup({
      symbol = "│",
      options = { try_as_border = true },
      draw = {
        delay = 0,
        animation = require("mini.indentscope").gen_animation.none(),
      },
    })

    -- Disable in certain filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
