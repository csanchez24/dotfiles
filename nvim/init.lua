-- init.lua
-- Neovim configuration entry point

-- ============================================================================
-- Performance - Load first
-- ============================================================================
-- Disable unused providers
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- ============================================================================
-- Load base configurations
-- ============================================================================
require("config.settings")
require("config.keymaps")
require("config.autocmds")

-- ============================================================================
-- Setup Lazy.nvim
-- ============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- Setup plugins
-- ============================================================================
require("lazy").setup({
  spec = {
    -- Simple plugins (no config needed)
    "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
    { "windwp/nvim-ts-autotag", event = "BufRead", opts = {} },

    -- Go support
    {
      "olexsmir/gopher.nvim",
      ft = "go",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
      opts = {},
    },

    -- Load all plugins from lua/plugins/
    { import = "plugins" },
  },

  -- Lazy.nvim configuration
  defaults = {
    lazy = false, -- Don't lazy load by default
    version = false, -- Use latest git commit
  },

  checker = {
    enabled = true, -- Check for plugin updates
    notify = false, -- Don't notify
  },

  change_detection = {
    enabled = true,
    notify = false,
  },

  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      -- Disable some rtp plugins
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },

  ui = {
    border = "rounded",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
