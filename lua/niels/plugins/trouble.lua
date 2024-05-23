return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>xx",
			function()
				require("trouble").toggle()
			end,
			mode = "n",
			desc = "open trouble for everything",
		},
		{
			"<leader>xw",
			function()
				require("trouble").toggle("workspace_diagnostics")
			end,
			mode = "n",
			desc = "open trouble workspace diagnostics",
		},
		{
			"<leader>xd",
			function()
				require("trouble").toggle("document_diagnostics")
			end,
			mode = "n",
			desc = "open trouble document diagnostics",
		},
		{
			"<leader>xq",
			function()
				require("trouble").toggle("quickfix")
			end,
			mode = "n",
			desc = "open trouble quickfixes",
		},
		{
			"<leader>xl",
			function()
				require("trouble").toggle("loclist")
			end,
			mode = "n",
			desc = "open trouble loclist",
		},
	},
	opts = {},
}
