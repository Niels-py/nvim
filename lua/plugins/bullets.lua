return {
  'bullets-vim/bullets.vim',
  ft = { 'markdown', 'text' },
  config = function()
    -- vim.g.bullets_outline_levels = { 'ROM', 'ABC', 'num', 'abc', 'rom', 'std-', 'std*', 'std+' }
    vim.g.bullets_outline_levels = { 'ROM', 'ABC', 'num', 'abc', 'rom', 'std-' }
  end,
}
