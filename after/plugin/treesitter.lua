require 'nvim-treesitter.configs'.setup {
    ensure_installed = { 
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "tsx",
        "typescript",
        "yaml",
        "rust",
        "go",
        "cpp",
        "c",
        "css",
        "csv",
        "nix",
        "sql"

    },

    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
}
