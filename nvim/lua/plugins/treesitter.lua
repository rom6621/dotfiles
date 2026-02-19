return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	main = "nvim-treesitter",
	opts = {
		ensure_installed = {
			"lua",
			"markdown",
			"html",
			"javascript",
			"typescript",
			"tsx",
			"go",
			"terraform",
			"python",
			"swift",
		},
		auto_install = true,
	},
}

