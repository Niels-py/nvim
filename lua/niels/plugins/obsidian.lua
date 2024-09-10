return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "/Documents/second-brain/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/Documents/second-brain/**.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter",
	},
	opts = {
		workspaces = {
			{
				name = "second-brain",
				path = "~/Documents/second-brain",
			},
		},
		-- Optional, if you keep notes in a specific subdirectory of your vault.
		notes_subdir = "notes",

		mappings = {
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
			["<leader>ot"] = {
				action = "<cmd>ObsidianTemplate<CR>",
			},
			["<leader>oo"] = {
				action = "<cmd>ObsidianOpen<CR>",
			},
			["<leader>ob"] = {
				action = "<cmd>ObsidianBacklinks<CR>",
			},
			["<leader>ol"] = {
				action = "<cmd>ObsidianLinks<CR>",
			},
			-- could use oil instead but this is nice as well
			["<leader>on"] = {
				action = "<cmd>ObsidianNew<CR>",
			},
			-- use <leader>g (ripgrep)
			-- ["<leader>os"] = {
			-- 	action = "<cmd>ObsidianSearch<CR>",
			-- },
			-- use <leader>f
			-- ["<leader>oq"] = {
			-- 	action = "<cmd>ObsidianQuickSwitch<CR>",
			-- },
		},
		new_notes_location = "current_dir",
		disable_frontmatter = true,

		-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
		-- URL it will be ignored but you can customize this behavior here.
		---@param url string
		follow_url_func = function(url)
			-- Open the URL in the default web browser.
			if vim.loop.os_uname().sysname == "Darwin" then
				vim.fn.jobstart({ "open", url }) -- Mac OS
			else
				vim.fn.jobstart({ "xdg-open", url }) -- linux
			end
		end,

		templates = {
			folder = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			substitutions = {
				yesterday = function()
					return os.date("%Y-%m-%d", os.time() - 86400)
				end,
				tomorrow = function()
					return os.date("%Y-%m-%d", os.time() + 86400)
				end,
				name = "Niels Haupt",
			},
		},

		-- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
		open_app_foreground = true,

		picker = {
			name = "telescope.nvim",
		},

		-- Optional, sort search results by "path", "modified", "accessed", or "created".
		-- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
		-- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
		sort_by = "modified",
		sort_reversed = true,

		open_notes_in = "current",

		ui = {
			enable = false, -- set to false to disable all additional syntax features
			update_debounce = 200, -- update delay after a text change (in milliseconds)
			-- Define how various check-boxes are displayed
			checkboxes = {
				-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
				-- [">"] = { char = "", hl_group = "ObsidianRightArrow" },
				-- ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
			},
			bullets = { char = "•", hl_group = "ObsidianBullet" },
			external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
			reference_text = { hl_group = "ObsidianRefText" },
			highlight_text = { hl_group = "ObsidianHighlightText" },
			tags = { hl_group = "ObsidianTag" },
			block_ids = { hl_group = "ObsidianBlockID" },
			hl_groups = {
				-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
				ObsidianTodo = { bold = true, fg = "#f78c6c" },
				ObsidianDone = { bold = true, fg = "#89ddff" },
				ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
				ObsidianTilde = { bold = true, fg = "#ff5370" },
				ObsidianBullet = { bold = true, fg = "#89ddff" },
				ObsidianRefText = { underline = true, fg = "#c792ea" },
				ObsidianExtLinkIcon = { fg = "#c792ea" },
				ObsidianTag = { italic = true, fg = "#89ddff" },
				ObsidianBlockID = { italic = true, fg = "#89ddff" },
				ObsidianHighlightText = { bg = "#75662e" },
			},
		},

		attachments = {
			img_folder = "assets/imgs", -- This is the default
		},
	},
}
