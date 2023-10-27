return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        }
    },
    lazy = false,
    config = function ()

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
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                        ["<Esc>"] = actions.close, -- close telescope on single hit of Escape
                    }
                }

            }
        }

        telescope.load_extension("fzf")

        local builtin = require('telescope.builtin')
        local key = vim.keymap

        key.set('n', '<leader>f', builtin.find_files, { desc = "Fuzzy find files in cwd" }) -- f for file
        key.set('n', '<leader>g', builtin.git_files, { desc = 'Find files in git repo' }) -- g for git
        key.set('n', '<leader>o', builtin.treesitter, { desc = 'Find function or variable or something like that' })
    end,
}
