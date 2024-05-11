return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-telescope/telescope-ui-select.nvim",

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		local actions = require("telescope.actions")
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				prompt_prefix = "❯ ",
				selection_caret = "➜ ",
				entry_prefix = "  ",
				selection_strategy = "reset",
				sorting_strategy = "descending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						mirror = false,
						prompt_position = "bottom",
					},
					vertical = {
						mirror = false,
					},
				},
				file_ignore_patterns = {
					".git/",
					".cache",
					"%.o",
					"%.a",
					"%.out",
					"%.class",
					"%.pdf",
					"%.mkv",
					"%.mp4",
					"%.zip",
				},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<Esc>"] = actions.close, -- close telescope on single hit of Escape
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				"fzf",
			},
			pickers = {
				find_files = {
					find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
				},
			},
		})

		local builtin = require("telescope.builtin")
		local map = function(keys, action, desc)
			vim.keymap.set("n", keys, action, { desc = desc })
		end

		map("<leader>f", builtin.find_files, "Fuzzy find files in cwd")
		map("<leader>t", builtin.treesitter, "Find function or variable or something like that")
		map("<leader>o", builtin.oldfiles, "Fuzzy find recently opend files")
		map("<leader>g", builtin.live_grep, "ripgrep in current buffer")
		map("<leader>h", builtin.help_tags, "lists help pages")
	end,
}
