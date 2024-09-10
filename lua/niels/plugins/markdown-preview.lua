return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_theme = ""
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/nvim/markdown.css")
		end,
	},
}
