return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        flavour = "mocha",
        transparent_background = true;
            integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            lualine = true,
        },
    },
    config = function()
        vim.cmd([[colorscheme catppuccin]])
    end,
}
