vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- relative linenumbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- indent
local tabw = 4
vim.opt.tabstop = tabw
vim.opt.softtabstop = tabw
vim.opt.shiftwidth = tabw
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
-- when wrapping lines, they will be indented
vim.opt.breakindent = true

-- no swapfiles and undotree gets access to old changes in undodir
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- files may have @ in ther name
vim.opt.isfname:append '@-@'

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- vim.opt.timeoutlen = 500

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
-- NOTE: noch nicht 100% überzeugt von dem Zeug
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 12

-- folding
vim.opt.foldenable = true
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('markdown_autofold', { clear = true }),
  pattern = { 'markdown' },
  callback = function()
    vim.cmd [[
    function! MarkdownFoldExpr()
    " Get the current line's content
    let line_content = getline(v:lnum)

    let heading_level = matchstr(line_content, '^##\+\s')
    if !empty(heading_level)
        return len(heading_level) - 2 "-2 gets rid of space in regex and disable fold for headinglevel 1
    endif

    let next_line_content = getline(v:lnum + 1)
    let next_heading_level = matchstr(next_line_content, '^##\+\s')
    if !empty(next_heading_level)
        return len(next_heading_level) - 3 "sets fold to foldlevel above
    endif

    return '='
endfunction
  ]]

    vim.opt_local.foldexpr = 'MarkdownFoldExpr()'
  end,
})

-- to make obsidian.nvim happy
vim.opt.conceallevel = 1
