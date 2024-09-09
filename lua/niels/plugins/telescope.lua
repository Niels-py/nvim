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
		-- "jvgrootveld/telescope-zoxide",
		"nvim-tree/nvim-web-devicons",
	},
	cmd = { "Telescope" },
	keys = {
		{
			"<leader>f",
			require("telescope.builtin").find_files,
			mode = "n",
			desc = "Fuzzy find files in cwd",
		},
		{
			"<leader>t",
			require("telescope.builtin").treesitter,
			mode = "n",
			desc = "Find function or variable or something like that",
		},
		{
			"<leader>o",
			require("telescope.builtin").oldfiles,
			mode = "n",
			desc = "Fuzzy find recently opend files",
		},
		{
			"<leader>g",
			require("telescope.builtin").live_grep,
			mode = "n",
			desc = "ripgrep in current buffer",
		},
		{
			"<leader>h",
			function()
				require("telescope.builtin").help_tags()
			end,
			mode = "n",
			desc = "find zoxide folders",
		},
		{
			"<leader>m",
			function()
				require("telescope").extensions.media_files.media_files()
			end,
			mode = "n",
			desc = "find media files (copy path on select)",
		},
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
