-- nvim/lua/plugins/java.lua
-- Java support via nvim-jdtls (eclipse.jdt.ls)
-- The actual server setup lives in lua/config/jdtls.lua, which registers a
-- FileType autocmd. lazy.nvim re-fires the FileType event after loading the
-- plugin, so the autocmd runs for the buffer that triggered the load.
-- https://github.com/mfussenegger/nvim-jdtls

return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
  },
  config = function()
    require("config.jdtls")
  end,
}
