return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { desc = desc })
		end

		local gs = require("gitsigns")

		map("]h", gs.next_hunk, "Next Hunk") -- hunk is a git change (or delete or add usw.)
		map("[h", gs.prev_hunk, "Prev Hunk")

		gs.setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		})
	end,
}
