return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint" },
			typescript = { "eslint" },
			javascriptreact = { "eslint" },
			typescriptreact = { "eslint" },
			svelte = { "eslint" },
			lua = { "selene" },
			css = { "stylint" },
			python = { "ruff" },
			go = { "golangcilint" },
			-- haskell = { "hlint" },
			markdown = { "vale" },
			xml = { "vale" },
			html = { "vale" },
			org = { "vale" },
			rust = { "clippy" },
			bash = { "bash" },
			yaml = { "yamllint" },
			c = { "clangtidy" },
			cpp = { "clangtidy" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
