return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>F',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function()
      return {
        timeout_ms = 2000,
        lsp_format = 'fallback',
      }
    end,

    -- langs that work via lsp:
    -- rust   = rust_analyzer
    -- go     = gopls
    -- java   = jdtls
    -- c      = clangd
    -- python = ruff
    -- lua    = lua_ls

    formatters_by_ft = {
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      haskell = { 'ormolu' },
      markdown = { 'markdownlint' },
    },
  },
}
