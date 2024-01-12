return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            transparent_background = true,
            term_colors = true,
            compile = {
                enabled = false,
                path = vim.fn.stdpath("cache") .. "/catppuccin",
            },
            dim_inactive = {
                enabled = false,
                shade = "dark",
                percentage = 0.15,
            },
            styles = {
                comments = { "italic" },
                conditionals = { "italic" },
                loops = { "bold" },
                functions = { "italic" },
                keywords = { "bold" },
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                markdown = true,
            },
            color_overrides = {},
            highlight_overrides = {},
        })

        vim.cmd([[colorscheme catppuccin]])
    end,
}
