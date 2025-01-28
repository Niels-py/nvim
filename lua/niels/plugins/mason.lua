return {
	"williamboman/mason.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- "rshkarin/mason-nvim-lint",
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
			jdtls = {},
			-- hls = {},
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

		local linters = {
			"eslint",
			"selene",
			"golangci-lint",
			-- "hlint",
			"vale",
			"yamllint",
			"clang-format",
		}

		local formatters = {

			"stylua", -- Used to format Lua code
			"black",
			"ruff",
			"isort",
			"taplo",
			"beautysh",
			"stylelint",
			-- "jq",
			"codelldb",
			"codespell",
			"goimports",
		}

		-- make ensure_installed with all servers from servers variable
		local ensure_installed = vim.tbl_keys(servers or {})

		-- adding linters and formatters to get installed as well
		vim.list_extend(ensure_installed, linters)
		vim.list_extend(ensure_installed, formatters)

		-- setup nvim lint to use mason linter
		-- require("mason-nvim-lint").setup()

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
					server.capabilities = require("blink.cmp").get_lsp_capabilities(server.capabilities)
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
