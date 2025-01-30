return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      vim.g.mkdp_theme = ''
      vim.g.mkdp_filetypes = { 'markdown' }
      vim.g.mkdp_markdown_css = vim.fn.expand '~/.config/nvim/markdown.css'
    end,
  },
}
