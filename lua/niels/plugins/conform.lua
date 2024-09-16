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
			mode = "n",
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = function(bufnr)
				if require("conform").get_formatter_info("ruff_format", bufnr).available then
					return { "ruff_format" }
				else
					return { "isort", "black" }
				end
			end,
			go = { "goimports", "gofmt" },
			bash = { "beautysh" },
			rust = { "rustfmt", lsp_format = "fallback" },
			toml = { "taplo" },
			zig = { "zigfmt" },
			json = { "jq" },
			-- c = { "clangd" },
			-- cpp = { "clangd" },
			-- Use the "*" filetype to run formatters on all filetypes.
			["*"] = { "codespell" },
		},
		format_on_save = {
			-- These options will be passe to conform.format()
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
