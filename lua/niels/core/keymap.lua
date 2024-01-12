local key = vim.keymap.set

vim.g.mapleader = " "

-- moving selection on line up or down with line indent
key("v", "J", ":m '>+1<CR>gv=gv")
key("v", "K", ":m '<-2<CR>gv=gv")

-- copy & paste stuff
key({ "n", "v" }, "<leader>y", [["+y]])
key("n", "<leader>Y", [["+Y]])
key("n", "<leader>p", [["+p]])

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
key("n", "<leader>a", [[:e %:p:h/]]) -- new file in dir of current file
key("n", "<leader>e", [[:e .]]) -- open netrw
