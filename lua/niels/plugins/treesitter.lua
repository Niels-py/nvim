return {
    'nvim-treesitter/nvim-treesitter',
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
                'tsx',
                'typescript',
                'yaml',
                'rust',
                'cpp',
                'css',
                'csv',
                'sql'
            },

            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            auto_install = true,
        })
    end,
}
