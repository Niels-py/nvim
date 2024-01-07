return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = { "BufReadPre", "BufNewFile" },
    config = function() 
        require('lualine').setup {
            options = {
                theme = "catppuccin"
            }
        }
    end,
}
