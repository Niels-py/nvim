return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>F",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			go = { "gofmt" },
			bash = { "beautysh" },
			rust = { "rustfmt" },
			toml = { "taplo" },
			zig = { "zigfmt" },
			json = { "jq" },
		},
		format_on_save = {
			-- These options will be passe to conform.format()
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
