return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
        "nvim-telescope/telescope-ui-select.nvim",

        -- Useful for getting pretty icons, but requires a Nerd Font.
        { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
        local actions = require('telescope.actions')
        local telescope = require('telescope')

        telescope.setup {
            defaults = {
                vimgrep_arguments = {
                    'rg',
                    '--color=always',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case'
                },
                prompt_prefix = "❯ ",
                selection_caret = "➜ ",
                entry_prefix = "  ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "descending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        mirror = false,
                        prompt_position = 'bottom',
                    },
                    vertical = {
                        mirror = false,
                    },
                },
                file_ignore_patterns = { ".git/", ".cache", "%.o", "%.a", "%.out",
                    "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip" },
                borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },

                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next,     -- move to next result
                        ["<Esc>"] = actions.close,                   -- close telescope on single hit of Escape
                    }
                }

            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
            pickers = {
                find_files = {
                    find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
                }
            }
        }

        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        local builtin = require('telescope.builtin')
        local map = vim.keymap.set

        map('n', '<leader>f', builtin.find_files, { desc = "Fuzzy find files in cwd" })
        map('n', '<leader>o', builtin.treesitter, { desc = 'Find function or variable or something like that' })
        map('n', '<leader>r', builtin.oldfiles, { desc = "Fuzzy find recently opend files"})
    end,
}
