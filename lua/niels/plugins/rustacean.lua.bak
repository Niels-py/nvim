return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = true, -- This plugin is already lazy
	ft = "rust",
	["rust-analyzer"] = {
		checkOnSave = {
			command = "clippy",
		},
		imports = {
			granularity = {
				group = "module",
			},
			prefix = "self",
		},
		cargo = {
			allFeatures = true,
			buildScripts = {
				enable = true,
			},
		},
		procMacro = {
			enable = true,
		},
	},
	config = function()
		local mason_registry = require("mason-registry")
		local codelldb = mason_registry.get_package("codelldb")
		local extension_path = codelldb:get_install_path() .. "/extension/"
		local codelldb_path = extension_path .. "adapter/codelldb"
		local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
		local cfg = require("rustaceanvim.config")

		return {
			dap = {
				adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
			},
		}
	end,
}
