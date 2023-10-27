return {
    'utilyre/barbecue.nvim',
    tag = 'v1.2.0',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        'SmiteshP/nvim-navic',
        'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    opts = {
        theme = 'catppuccin',
    }
}
