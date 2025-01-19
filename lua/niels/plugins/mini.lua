return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		----------------------------------------
		-- Text editing
		----------------------------------------

		require("mini.ai").setup()
		require("mini.align").setup()
		require("mini.comment").setup()
		-- require("mini.completion").setup()
		require("mini.move").setup()
		-- require("mini.operators").setup()
		require("mini.pairs").setup()
		-- require("mini.snippets").setup()
		require("mini.splitjoin").setup()
		require("mini.surround").setup()

		----------------------------------------
		-- General workflow
		----------------------------------------

		----------------------------------------
		-- Appearance
		----------------------------------------

		-- require("mini.hipatterns").setup()
		-- require("mini.icons").setup()
		-- require("mini.icons").tweak_lsp_kind()
	end,
}
