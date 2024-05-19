return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-telescope/telescope-media-files.nvim",
		"nvim-lua/popup.nvim",
		"jvgrootveld/telescope-zoxide",

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local action_layout = require("telescope.actions.layout")
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
					"%.zip",
				},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-p>"] = action_layout.toggle_preview,
						["<Esc>"] = actions.close,
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				"fzf",
				media_files = {
					filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "mkv" },
				},
				"zoxide",
			},
			pickers = {
				find_files = {
					find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
				},
			},
		})
	end,
}
