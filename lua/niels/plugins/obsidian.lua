return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	event = {
		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		"BufReadPre "
			.. vim.fn.expand("~")
			.. "/Documents/second-brain/**.md",
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

		-- daily_notes = {
		-- 	-- Optional, if you keep daily notes in a separate directory.
		-- 	folder = "notes/dailies",
		-- 	-- Optional, if you want to change the date format for the ID of daily notes.
		-- 	date_format = "%Y-%m-%d",
		-- 	-- Optional, if you want to change the date format of the default alias of daily notes.
		-- 	alias_format = "%B %-d, %Y",
		-- 	-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
		-- 	template = "daily.md",
		-- },

		-- way then set 'mappings = {}'.
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			-- Smart action depending on context, either follow link or toggle checkbox.
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},

		-- Where to put new notes. Valid options are
		--  * "current_dir" - put new notes in same directory as the current buffer.
		--  * "notes_subdir" - put new notes in the default notes subdirectory.
		new_notes_location = "current_dir",

		-- the tag and id and stuff at the beginning of a file
		disable_frontmatter = true,

		-- Optional, for templates (see below).
		-- templates = {
		-- 	subdir = "templates",
		-- 	date_format = "%Y-%m-%d",
		-- 	time_format = "%H:%M",
		-- 	-- A map for custom variables, the key should be the variable and the value a function
		-- 	substitutions = {},
		-- },

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

		-- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
		open_app_foreground = false,

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
			enable = true, -- set to false to disable all additional syntax features
			update_debounce = 200, -- update delay after a text change (in milliseconds)
			-- Define how various check-boxes are displayed
			checkboxes = {
				-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
				-- [">"] = { char = "", hl_group = "ObsidianRightArrow" },
				-- ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
				-- Replace the above with this if you don't have a patched font:
				-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
				-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

				-- You can also add more custom ones...
			},
			-- Use bullet marks for non-checkbox lists.
			bullets = { char = "•", hl_group = "ObsidianBullet" },
			external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
			-- Replace the above with this if you don't have a patched font:
			-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
			reference_text = { hl_group = "ObsidianRefText" },
			highlight_text = { hl_group = "ObsidianHighlightText" },
			tags = { hl_group = "ObsidianTag" },
			block_ids = { hl_group = "ObsidianBlockID" },
			-- hl_groups = {
			--     -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
			--     ObsidianTodo = { bold = true, fg = "#f78c6c" },
			--     ObsidianDone = { bold = true, fg = "#89ddff" },
			--     ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
			--     ObsidianTilde = { bold = true, fg = "#ff5370" },
			--     ObsidianBullet = { bold = true, fg = "#89ddff" },
			--     ObsidianRefText = { underline = true, fg = "#c792ea" },
			--     ObsidianExtLinkIcon = { fg = "#c792ea" },
			--     ObsidianTag = { italic = true, fg = "#89ddff" },
			--     ObsidianBlockID = { italic = true, fg = "#89ddff" },
			--     ObsidianHighlightText = { bg = "#75662e" },
			-- },
		},

		attachments = {
			img_folder = "assets/imgs", -- This is the default
		},
	},
}
