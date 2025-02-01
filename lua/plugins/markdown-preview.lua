return {
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    config = function()
      vim.g.mkdp_theme = ''
      vim.g.mkdp_markdown_css = vim.fn.expand '~/.config/nvim/markdown.css'
      -- vim.g.mkdp_port = '6969'

      -- vim.cmd [[do FileType]]
      vim.cmd [[
        function OpenMarkdownPreview (url)
          if has('darwin')
            let cmd = "open -a Firefox -n --args --new-window " . shellescape(a:url) . " &"
          elseif has('unix')
            let cmd = "firefox --new-window " . shellescape(a:url) . " &"
          endif
          silent call system(cmd)
        endfunction
      ]]
      vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
    end,
  },
}
