local o = vim.opt

o.nu = true -- line numbers
o.rnu = true -- relative line numbers

-- indent
local tabw = 4
o.tabstop = tabw
o.softtabstop = tabw
o.shiftwidth = tabw
o.expandtab = true
o.smartindent = true

o.wrap = true -- text wrapping

-- no swapfiles and undotree gets acsas to old changes in undodir
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true

-- search settings
o.hlsearch = false
o.incsearch = true

o.termguicolors = true

o.scrolloff = 10
o.signcolumn = "yes"
o.isfname:append("@-@")

o.updatetime = 100

o.colorcolumn = "80"

-- no swapfile creation
o.swapfile = false

-- folding
o.foldenable = true
o.foldmethod = "marker"
vim.g.markdown_folding = 1
