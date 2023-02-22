local key = vim.keymap.set

vim.g.mapleader = " "

key("n", "<leader>d", vim.cmd.Ex)
key("v", "J", ":m '>+1<CR>gv=gv")
key("v", "K", ":m '<-2<CR>gv=gv")

key("n", "<C-d>", "<C-d>zz")
key("n", "<C-u>", "<C-u>zz")
key("n", "n", "nzzzv")
key("n", "N", "Nzzzv")

-- greatest remap ever
key("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
key({ "n", "v" }, "<leader>y", [["+y]])
key("n", "<leader>Y", [["+Y]])

key("n", "<leader>F", vim.lsp.buf.format)

key("n", "<C-k>", "<cmd>cnext<CR>zz")
key("n", "<C-j>", "<cmd>cprev<CR>zz")
key("n", "<leader>k", "<cmd>lnext<CR>zz")
key("n", "<leader>j", "<cmd>lprev<CR>zz")

key("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- tabs
key("n", "<leader>t", vim.cmd.tabnew)
key("n", "<leader>w", vim.cmd.tabclose)
