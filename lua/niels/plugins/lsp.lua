return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local opts = { noremap = true, silent = true }

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
				map("K", vim.lsp.buf.hover, "Show Documentation for whats under the cursor")
				map("<leader>d", vim.diagnostic.open_float, "shows diagnostic in float window")
				map("gD", vim.lsp.buf.declaration, "Goto Declaration")
				map("[d", vim.diagnostic.goto_prev, "jump to previous diagnostic in buffer")
				map("]d", vim.diagnostic.goto_next, "jump to next diagnostic in buffer")

				-- The following autocommand is used to enable inlay hints in your
				-- code, if the language server you are using supports them
				--
				-- This may be unwanted, since they displace some of your code
				if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- mmmmm   mmm    mmm    mmm   m mm
		-- # # #  "   #  #   "  #" "#  #"  #
		-- # # #  m"""#   """m  #   #  #   #
		-- # # #  "mm"#  "mmm"  "#m#"  #   #

		require("mason").setup({
			ui = {
				icons = {
					package_installed = " ",
					package_pending = " ",
					package_uninstalled = " ",
				},
			},
		})

		-- server config
		local servers = {
			gopls = {},
			pyright = {},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			},
			jdtls = {},

			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {

							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							disable = { "missing-fields" },

							-- Get the language server to recognize the `vim` global
							globals = {
								"vim",
								"require",
							},
						},
						workspace = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
						telemetry = {
							enabled = false,
						},
					},
				},
			},
		}

		-- make ensure_installed with all servers from servers variable
		local ensure_installed = vim.tbl_keys(servers or {})
		-- add addtitional stuff to install
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
			"black",
			"tsserver",
			"prettier",
			"bashls",
			"yamlls",
			"ruff",
			"isort",
			"taplo",
			"beautysh",
			"eslint_d",
			"stylelint",
			"golangci-lint",
		})

		-- install everything
		require("mason-tool-installer").setup({
			ensure_installed = ensure_installed,
			auto_update = true,
			run_on_start = true,
		})

		-- configure stuff from servers
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = require("cmp_nvim_lsp").default_capabilities()
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
