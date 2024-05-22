return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				go = { "gofmt" },
				bash = { "beautysh" },
				rust = { "rustfmt" },
				toml = { "taplo" },
				zig = { "zigfmt" },
			},
			format_on_save = {
				-- These options will be passe to conform.format()
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})
	end,
}
