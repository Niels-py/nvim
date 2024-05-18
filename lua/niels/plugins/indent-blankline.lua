return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	version = "3.5.4", -- version 3.6.0 is broken on nvim_version < 10.0.0
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		scope = {
			enabled = false,
		},
		exclude = {
			filetypes = {
				"lazy",
				"lazyterm",
			},
		},
	},
}
