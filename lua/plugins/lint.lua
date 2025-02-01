return {
  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- configuration of linters
      lint.linters['markdownlint-cli2'].args = {
        '--config',
        vim.fn.expand '~/.config/nvim/markdownlint.yaml',
        '--',
      }

      lint.linters_by_ft = {
        markdown = { 'markdownlint-cli2' },
        haskell = { 'hlint' },
      }

      -- installed via lsp
      -- c = clangd
      -- python = ruff
      -- rust = rust_analyzer
      -- go = gopls
      -- java = jdtls

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
