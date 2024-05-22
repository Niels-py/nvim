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
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		defaults = {
			prompt_prefix = "❯ ",
			selection_caret = "➜ ",
			file_ignore_patterns = {
				".git/",
				".cache",
				"%.o",
				"%.a",
				"%.out",
				"%.class",
				"%.zip",
			},
			mappings = {
				i = {
					["<C-k>"] = require("telescope.actions").move_selection_previous,
					["<C-j>"] = require("telescope.actions").move_selection_next,
					["<Esc>"] = require("telescope.actions").close,
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
	},
}
