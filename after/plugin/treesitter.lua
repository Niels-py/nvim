require'nvim-treesitter.configs'.setup {
  ensure_installed = {"help", "c", "lua", "rust", "python", "bash", "arduino", "cpp", "css", "html", "java", "latex", "toml", "yaml"},

  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
