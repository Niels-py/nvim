local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = desc })
end

-- moving selection on line up or down with line indent
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected line up" })

-- format (needs lsp)
map("<leader>F", vim.lsp.buf.format, "formats code")

-- clear highlight of search by pressing ESC
map("<Esc>", "<cmd>nohlsearch<CR>")

-- window movement
-- map("<C-h>", "<C-w><C-h>", "Move focus to the left window" )
-- map("<C-l>", "<C-w><C-l>", "Move focus to the right window" )
-- map("<C-j>", "<C-w><C-j>", "Move focus to the lower window" )
-- map("<C-k>", "<C-w><C-k>", "Move focus to the upper window" )

-- replace selected word in whole file
-- map("<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "replace word under cursor in whole file")

-- tabs
-- map("<leader>t", vim.cmd.tabnew, "Opens new tab")
-- map("<leader>w", vim.cmd.tabclose, "Closes current tab")
-- map("<leader><tab>", vim.cmd.tabnext, "switch to next tab")
-- map("<leader><S-tab>", vim.cmd.tabprevious, "switch to prev tab")

-- file management
map("<leader>n", "<CMD>Oil<CR>", "open oil")

-- trouble
local trouble = require("trouble")
map("<leader>xx", function()
	trouble.toggle()
end, "open trouble everything")
map("<leader>xw", function()
	trouble.toggle("workspace_diagnostics")
end, "open trouble workspace diagnostic")
map("<leader>xd", function()
	trouble.toggle("document_diagnostics")
end, "open trouble diagnostics of current buffer")
map("<leader>xq", function()
	trouble.toggle("quickfix")
end, "open trouble quickfixes")
map("<leader>xl", function()
	trouble.toggle("loclist")
end, "open trouble loclist")

-- git
local gs = require("gitsigns")
map("]h", gs.next_hunk, "Next Hunk") -- hunk is a git change (or delete or add usw.)
map("[h", gs.prev_hunk, "Prev Hunk")

-- harpoon
local harpoon = require("harpoon")
harpoon:setup()
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end
map("<leader>a", function()
	harpoon:list():add()
end, "add buffer to harpoon list")
map("<leader>e", function()
	toggle_telescope(harpoon:list())
end, "Open harpoon window")
map("<leader>j", function()
	harpoon:list():next()
end, "jump to next harpoon buffer")
map("<leader>k", function()
	harpoon:list():prev()
end, "jump to prev harpoon buffer")
map("<leader>1", function()
	harpoon:list():select(1)
end, "jump to harpoon buffer 1")
map("<leader>2", function()
	harpoon:list():select(2)
end, "jump to harpoon buffer 2")
map("<leader>3", function()
	harpoon:list():select(3)
end, "jump to harpoon buffer 3")
map("<leader>4", function()
	harpoon:list():select(4)
end, "jump to harpoon buffer 4")
