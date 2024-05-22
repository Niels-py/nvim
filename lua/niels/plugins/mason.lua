return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
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
			bashls = {},
			yamlls = {},
			gopls = {
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
				gofumpt = true,
				hints = {
					-- https://github.com/golang/tools/blob/master/gopls/doc/inlayHints.md
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
			basedpyright = {},
			rust_analyzer = {
				on_attach = function(_)
					vim.lsp.inlay_hint.enable(true)
				end,
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
						imports = {
							granularity = {
								group = "module",
							},
							prefix = "self",
						},
						cargo = {
							buildScripts = {
								enable = true,
							},
						},
						procMacro = {
							enable = true,
						},
					},
				},
			},
			marksman = {},
			zls = {},
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						runtime = { version = "LuaJIT" },
						diagnostics = {
							globals = {
								"vim",
								"require",
							},
						},
						workspace = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
						telemetry = { enable = false },
						hint = { enable = true },
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
			"ruff",
			"isort",
			"taplo",
			"beautysh",
			"stylelint",
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
