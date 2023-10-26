return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = false,
    config = function ()
        require('telescope').setup {
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

            }
        }

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>f', builtin.find_files, {}) -- f for file
        vim.keymap.set('n', '<leader>g', builtin.git_files, {}) -- g for git
        vim.keymap.set('n', '<leader>o', builtin.treesitter, {})
        
    end,
}
