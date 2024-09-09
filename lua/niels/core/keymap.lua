-- moving selection on line up or down with line indent
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected line up" })

-- clear highlight of search by pressing ESC
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- window movement
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", "Move focus to the left window" )
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", "Move focus to the right window" )
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", "Move focus to the lower window" )
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", "Move focus to the upper window" )

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "replace word under cursor in whole file")

-- tabs
-- vim.keymap.set("n", "<leader>t", vim.cmd.tabnew, "Opens new tab")
-- vim.keymap.set("n", "<leader>w", vim.cmd.tabclose, "Closes current tab")
-- vim.keymap.set("n", "<leader><tab>", vim.cmd.tabnext, "switch to next tab")
-- vim.keymap.set("n", "<leader><S-tab>", vim.cmd.tabprevious, "switch to prev tab")
