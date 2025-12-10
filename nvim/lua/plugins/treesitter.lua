return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	install = function()
		require("nvim-treesitter.install").setup({
			prefer_git = false,
			compilers = { "gcc" }
		})
	end,
	config = function()
		require("nvim-treesitter.configs").setup({
			auto_install = false,
			ensure_installed = {
				"lua",
				"markdown",
				"html",
				"javascript",
				"typescript",
				"tsx",
				"go",
				"terraform",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}

