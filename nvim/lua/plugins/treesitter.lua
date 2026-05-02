-- Treesitter configuration for Neovim 0.12+
-- https://github.com/neovim-treesitter/nvim-treesitter

local parsers = {
	"blade",
	"bash",
	"c",
	"css",
	"diff",
	"dockerfile",
	"ecma",
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"go",
	"gomod",
	"gosum",
	"html",
	"html_tags",
	"javascript",
	"jsdoc",
	"jsx",
	"json",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"php",
	"php_only",
	"phpdoc",
	"python",
	"query",
	"regex",
	"sql",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
}

local filetypes = {
	"blade",
	"bash",
	"c",
	"css",
	"diff",
	"dockerfile",
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"go",
	"gomod",
	"gosum",
	"html",
	"javascript",
	"javascriptreact",
	"json",
	"jsonc",
	"lua",
	"markdown",
	"php",
	"python",
	"query",
	"regex",
	"sql",
	"toml",
	"tsx",
	"typescript",
	"typescriptreact",
	"vim",
	"vimdoc",
	"yaml",
}

return {
	"neovim-treesitter/nvim-treesitter",
	name = "nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	dependencies = {
		"neovim-treesitter/treesitter-parser-registry",
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
			opts = {
				move = {
					set_jumps = true,
				},
			},
			config = function(_, opts)
				local ok_textobjects, textobjects = pcall(require, "nvim-treesitter-textobjects")
				if not ok_textobjects then
					return
				end
				textobjects.setup(opts)

				local ok_move, move = pcall(require, "nvim-treesitter-textobjects.move")
				if not ok_move then
					return
				end

				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { desc = desc })
				end

				map({ "n", "x", "o" }, "]f", function()
					move.goto_next_start("@function.outer", "textobjects")
				end, "Next function start")
				map({ "n", "x", "o" }, "]F", function()
					move.goto_next_end("@function.outer", "textobjects")
				end, "Next function end")
				map({ "n", "x", "o" }, "[f", function()
					move.goto_previous_start("@function.outer", "textobjects")
				end, "Previous function start")
				map({ "n", "x", "o" }, "[F", function()
					move.goto_previous_end("@function.outer", "textobjects")
				end, "Previous function end")

				map({ "n", "x", "o" }, "]c", function()
					if vim.wo.diff then
						return vim.cmd("normal! ]c")
					end
					move.goto_next_start("@class.outer", "textobjects")
				end, "Next class start")
				map({ "n", "x", "o" }, "]C", function()
					if vim.wo.diff then
						return vim.cmd("normal! ]C")
					end
					move.goto_next_end("@class.outer", "textobjects")
				end, "Next class end")
				map({ "n", "x", "o" }, "[c", function()
					if vim.wo.diff then
						return vim.cmd("normal! [c")
					end
					move.goto_previous_start("@class.outer", "textobjects")
				end, "Previous class start")
				map({ "n", "x", "o" }, "[C", function()
					if vim.wo.diff then
						return vim.cmd("normal! [C")
					end
					move.goto_previous_end("@class.outer", "textobjects")
				end, "Previous class end")
			end,
		},
	},
	config = function()
		require("nvim-treesitter").install(parsers)

		-- Explicitly register tsx parser for typescriptreact filetype
		-- (nvim-treesitter should do this, but being explicit is safer)
		vim.treesitter.language.register("tsx", "typescriptreact")
		vim.treesitter.language.register("javascript", "javascriptreact")

		-- TSX fix: manually combine query files to avoid broken inheritance chain
		-- (tsx/highlights.scm uses "; inherits: ecma,jsx,typescript" which doesn't
		-- resolve correctly in neovim-treesitter main branch)
		local function set_tsx_highlights()
			local chunks = {}

			for _, lang in ipairs({ "ecma", "jsx", "typescript", "tsx" }) do
				for _, file in ipairs(vim.api.nvim_get_runtime_file("queries/" .. lang .. "/highlights.scm", true)) do
					for _, line in ipairs(vim.fn.readfile(file)) do
						if not line:match("^%s*;%s*inherits:") then
							table.insert(chunks, line)
						end
					end
				end
			end

			local source = table.concat(chunks, "\n")
			if source ~= "" then
				pcall(vim.treesitter.query.set, "tsx", "highlights", source)
			end
		end

		set_tsx_highlights()

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("ag__treesitter", { clear = true }),
			pattern = filetypes,
			callback = function(event)
				vim.treesitter.start(event.buf)
				vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		vim.api.nvim_create_user_command("TSResetHighlight", function()
			pcall(vim.treesitter.stop, 0)
			vim.treesitter.start()
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end, { desc = "Restart Treesitter highlighting for current buffer" })
	end,
}
