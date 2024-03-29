local o = vim.opt

o.number = true
o.relativenumber = true

-- indent
local tabw = 4
o.tabstop = tabw
o.softtabstop = tabw
o.shiftwidth = tabw
o.expandtab = true
o.smartindent = true

o.wrap = false -- text wrapping

-- cursor highlight
-- o.cursorcolumn = true
o.cursorline = true

-- no swapfiles and undotree gets access to old changes in undodir
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

-- o.colorcolumn = "80"

-- no swapfile creation
o.swapfile = false

-- folding
o.foldenable = true
o.foldmethod = "marker"

-- terminal cursor should not change
o.gcr = 'n-v-o:block,i-c:ver20,r-cr:hor20,o:hor50'

-- to make obsidian.nvim happy
o.conceallevel = 1
