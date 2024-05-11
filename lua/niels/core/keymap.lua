-- moving selection on line up or down with line indent
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected line up" })

-- format (needs lsp)
vim.keymap.set("n", "<leader>F", vim.lsp.buf.format)

-- clear highlight of search by pressing ESC
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- window movement
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- replace selected word in whole file
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "replace word under cursor in whole file"})

-- tabs
-- vim.keymap.set("n", "<leader>t", vim.cmd.tabnew, { desc = "Opens new tab"})
-- vim.keymap.set("n", "<leader>w", vim.cmd.tabclose, { desc = "Closes current tab"})
-- vim.keymap.set("n", "<leader><tab>", vim.cmd.tabnext, { desc = "switch to next tab"})
-- vim.keymap.set("n", "<leader><S-tab>", vim.cmd.tabprevious, { desc = "switch to prev tab"})

-- file management
vim.keymap.set("n", "<leader>n", "<CMD>Oil<CR>", { desc = "open oil" })

-- trouble
vim.keymap.set("n", "<leader>xx", function()
	require("trouble").toggle()
end)
vim.keymap.set("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end)
vim.keymap.set("n", "gR", function()
	require("trouble").toggle("lsp_references")
end)
