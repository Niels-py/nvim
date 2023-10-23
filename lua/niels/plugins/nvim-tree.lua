return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    cmd = "NvimTreeToggle",
    keys = {
        { '<leader>n', '<cmd>NvimTreeToggle<cr>', desc = 'NvimTree' },
    },
    opts = {
        view = { float = { enable = true } }
    }
}
