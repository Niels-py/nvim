require("tokyonight").setup({
    style = "night",
    styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},

        sidebars = "light",
        floats = "light",
    }
})
vim.cmd [[colorscheme tokyonight]]
