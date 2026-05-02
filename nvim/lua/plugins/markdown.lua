-- Render markdown inline with visual formatting
-- https://github.com/MeanderingProgrammer/render-markdown.nvim

return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" }, -- Solo carga en archivos markdown
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons", -- Opcional, para iconos
  },

  opts = {
    -- Renderizar en estos modos (normal, visual, etc)
    render_modes = { "n", "v", "i", "c" },

    -- Anti-conceal: muestra raw markdown en la línea del cursor
    anti_conceal = {
      enabled = true, -- La línea actual muestra sintaxis raw
      ignore = {
        code_background = true, -- Mantener fondo de code blocks
        sign = true,
      },
    },

    -- Headers con colores y símbolos
    heading = {
      enabled = true,
      sign = true, -- Icono en el sign column
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      -- Colores por nivel (usa tus colores de Dracula Pro)
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
    },

    -- Code blocks con fondo destacado
    code = {
      enabled = true,
      sign = true,
      style = "full", -- full, normal, language, none
      position = "left", -- left o right
      width = "full", -- full o block
      left_pad = 2,
      right_pad = 2,
      border = "thin", -- thin, thick, none
      above = "▄",
      below = "▀",
      highlight = "RenderMarkdownCode",
      highlight_inline = "RenderMarkdownCodeInline",
    },

    -- Bullet points con símbolos
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
      highlight = "RenderMarkdownBullet",
    },

    -- Checkboxes visuales
    checkbox = {
      enabled = true,
      unchecked = {
        icon = "󰄱 ", -- ☐
        highlight = "RenderMarkdownUnchecked",
      },
      checked = {
        icon = "󰱒 ", -- ☑
        highlight = "RenderMarkdownChecked",
      },
      custom = {
        todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
      },
    },

    -- Links
    link = {
      enabled = true,
      image = "󰥶 ",
      email = "󰀓 ",
      hyperlink = "󰌹 ",
      highlight = "RenderMarkdownLink",
    },

    -- Horizontal rules
    dash = {
      enabled = true,
      icon = "─",
      width = "full",
      highlight = "RenderMarkdownDash",
    },

    -- Quotes/blockquotes
    quote = {
      enabled = true,
      icon = "▋",
      repeat_linebreak = true,
      highlight = "RenderMarkdownQuote",
    },

    -- Tablas
    pipe_table = {
      enabled = true,
      preset = "round", -- none, round, double, heavy
      style = "full", -- full, normal, none
      cell = "padded", -- padded, raw, overlay
      alignment_indicator = "━",
      head = "RenderMarkdownTableHead",
      row = "RenderMarkdownTableRow",
    },

    latex = {
      enabled = false,
    },

    -- Callouts (> [!NOTE], > [!WARNING], etc)
    callout = {
      note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
      tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
      important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
      warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
      caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
    },

    -- Sign column icons
    sign = {
      enabled = true,
      highlight = "RenderMarkdownSign",
    },

    -- Inline highlighting (bold, italic)
    inline_highlight = {
      enabled = true,
    },

    -- Indent guides dentro de markdown
    indent = {
      enabled = true,
      per_level = 2,
    },

    -- Win options cuando render está activo
    win_options = {
      conceallevel = {
        default = vim.api.nvim_get_option_value("conceallevel", {}),
        rendered = 3,
      },
      concealcursor = {
        default = vim.api.nvim_get_option_value("concealcursor", {}),
        rendered = "",
      },
    },
  },

  config = function(_, opts)
    require("render-markdown").setup(opts)

    -- Colores personalizados para Dracula Pro
    vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#FF80BF", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = "#9580FF", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = "#80FFEA", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = "#8AFF80", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = "#FFFF80", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = "#FFCA80", bold = true })

    vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { bg = "#2D1F2A" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { bg = "#1F1D2A" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { bg = "#1A2A28" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "#1A2A1A" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { bg = "#2A2A1A" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { bg = "#2A251A" })

    vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#161A1D" })
    vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = "#1E2225", fg = "#8AFF80" })
    vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { fg = "#80FFEA" })
    vim.api.nvim_set_hl(0, "RenderMarkdownChecked", { fg = "#8AFF80" })
    vim.api.nvim_set_hl(0, "RenderMarkdownUnchecked", { fg = "#708CA9" })
    vim.api.nvim_set_hl(0, "RenderMarkdownTodo", { fg = "#FFFF80" })
    vim.api.nvim_set_hl(0, "RenderMarkdownLink", { fg = "#80FFEA", underline = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownDash", { fg = "#414D58" })
    vim.api.nvim_set_hl(0, "RenderMarkdownQuote", { fg = "#708CA9", italic = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownTableHead", { fg = "#9580FF", bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownTableRow", { fg = "#F8F8F2" })

    -- Callout colors
    vim.api.nvim_set_hl(0, "RenderMarkdownInfo", { fg = "#80FFEA" })
    vim.api.nvim_set_hl(0, "RenderMarkdownSuccess", { fg = "#8AFF80" })
    vim.api.nvim_set_hl(0, "RenderMarkdownHint", { fg = "#9580FF" })
    vim.api.nvim_set_hl(0, "RenderMarkdownWarn", { fg = "#FFFF80" })
    vim.api.nvim_set_hl(0, "RenderMarkdownError", { fg = "#FF9580" })
  end,

  keys = {
    { "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown Render" },
  },
}
