return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },           -- Required
        { 'williamboman/mason.nvim' },         -- Optional
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },                -- Required
        { 'hrsh7th/cmp-nvim-lsp' },            -- Required
        {
            'L3MON4D3/LuaSnip',
            tag = 'v2.0.0',
            build = 'make install_jsregexp',
        }, -- Required
        { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    },
    config = function()
        local lsp_zero = require('lsp-zero')

        lsp_zero.on_attach(function(client, bufnr)
            lsp_zero.default_keymaps({ buffer = bufnr })
        end)

        lsp_zero.setup_servers({
            'lua_ls',
            'rust_analyzer',
            'bashls',
            'cssls',
            'clangd',
            'html',
            'jdtls',
            'marksman',
            'pyright',
            'sqlls',
            'yamlls',
            'tsserver',
            'nil_ls',
        })

        require('mason').setup()
        require('mason-lspconfig').setup({
            handlers = {
                lsp_zero.default_setup,
            },
        })
        require('mason-tool-installer').setup({
            ensure_installed = {
                'lua_ls',
                'rust_analyzer',
                'bashls',
                'cssls',
                'clangd',
                'html',
                'jdtls',
                'marksman',
                'pyright',
                'sqlls',
                'sqlfmt',
                'yamlls',
                'yamlling',
                'yamlfmt',
                'tsserver',
                'nil_ls',
                'black',
                'autopep8',
                'google-java-format',
                'prettier',
                'shfmt',
            }
        })
        local cmp = require('cmp')
        local cmp_action = require('lsp-zero').cmp_action()

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                            -- that way you will only jump inside the snippet region
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif cmp_action.jumpable(-1) then
                        cmp_action.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }
                ),
            })
        })
        local lua_opts = lsp_zero.nvim_lua_ls()
        require('lspconfig').lua_ls.setup(lua_opts)
    end,
    event = { "BufReadPre", "BufNewFile" },
}
