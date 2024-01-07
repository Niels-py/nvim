return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects'
    },
    build = ':TSUpdate',
    config = function()
        local configs = require('nvim-treesitter.configs')
        configs.setup({
            ensure_installed = {
                'bash',
                'lua',
                'python',
                'rust',
                'go',
                'c',
                'nix',
                'html',
                'javascript',
                'json',
                'markdown',
                'markdown_inline',
                'yaml',
                'rust',
                'cpp',
                'css',
                'sql'
            },

            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            auto_install = true,
        })
    end,
}
