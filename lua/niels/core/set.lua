vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

-- indent
local tabw = 4
vim.opt.tabstop = tabw
vim.opt.softtabstop = tabw
vim.opt.shiftwidth = tabw
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false -- text wrapping

-- cursor highlight
-- vim.opt.cursorcolumn = true
vim.opt.cursorline = true

-- no swapfiles and undotree gets access to old changes in undodir
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- search settings
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- for colorthemes
vim.opt.termguicolors = true

vim.opt.scrolloff = 16
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- vim.opt.colorcolumn = "80"

-- folding
vim.opt.foldenable = true
vim.opt.foldmethod = "marker"

-- terminal cursor should not change
-- vim.opt.gcr = 'n-v-o:block,i-c:ver20,r-cr:hor20,o:hor50'

-- to make obsidian.nvim happy
vim.opt.conceallevel = 1
