local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {}) -- f for file
vim.keymap.set('n', '<leader>g', builtin.git_files, {}) -- g for git
vim.keymap.set('n', '<leader>w', builtin.live_grep, {}) -- w for word
