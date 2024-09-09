return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},

	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				local telescope = require("telescope.builtin")

				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", telescope.lsp_definitions, "Goto Definition")
				map("gr", telescope.lsp_references, "Goto References")
				map("gI", telescope.lsp_implementations, "Goto Implementation")
				map("<leader>D", telescope.lsp_type_definitions, "Type Definition")
				map("<leader>rn", vim.lsp.buf.rename, "change name")
				map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				map("<leader>d", vim.diagnostic.open_float, "shows diagnostic in float window")
				map("gD", vim.lsp.buf.declaration, "Goto Declaration")
				map("<leader>#", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, "Toggle inlay hint")
			end,
		})

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
	end,
}
