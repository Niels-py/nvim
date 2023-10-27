local key = vim.keymap.set

vim.g.mapleader = " "

key("v", "J", ":m '>+1<CR>gv=gv")
key("v", "K", ":m '<-2<CR>gv=gv")

-- better page up & down
key("n", "<C-d>", "<C-d>zz")
key("n", "<C-u>", "<C-u>zz")

-- copy & paste stuff
key({ "n", "v" }, "<leader>y", [["+y]])
key("n", "<leader>Y", [["+Y]])
key("x", "<leader>p", [["_dP]])

-- format (needs lsp)
key("n", "<leader>F", vim.lsp.buf.format)

-- window movement
key("n", "<leader>h", "<C-w>h")
key("n", "<leader>l", "<C-w>l")
key("n", "<leader>j", "<C-w>j")
key("n", "<leader>k", "<C-w>k")

-- replace selected word in whole file
key("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- tabs
key("n", "<leader>t", vim.cmd.tabnew)
key("n", "<leader>w", vim.cmd.tabclose)
key("n", "<leader><tab>", vim.cmd.tabnext)
key("n", "<leader><S-tab>", vim.cmd.tabprevious)

-- file management
key("n", "<leader>a", [[:e %:p:h/]])
key("n", "<leader>n", vim.cmd.NvimTreeToggle)
