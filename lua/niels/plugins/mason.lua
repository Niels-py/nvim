return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	event = "VeryLazy",
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
			clangd = {
				cmd = {
					"clangd",
				},
			},
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
		-- add additional stuff to install
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
			"black",
			"ruff",
			"isort",
			"taplo",
			"beautysh",
			"stylelint",
			"jq",
			"codelldb",
			"codespell",
			"goimports",
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
