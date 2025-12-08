return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"lua",
			"go",
		},
		highlight = { enable = true },
		indent = { enable = true },
	},
}

