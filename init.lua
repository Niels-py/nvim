-- --------------------------------
-- Options
-- --------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- relative linenumbers
vim.opt.number = true
vim.opt.relativenumber = true

-- mouse only for [v]isual mode and [i]nsert mode
vim.opt.mouse = 'vi'

-- indent
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- enable break indent
-- when wrapping lines, they will be indented
vim.opt.breakindent = true

-- no swapfiles and undotree gets access to old changes in undodir
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

-- case-insensitive searching unless \c or one or more capital letters in the search term
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- files may have @ in ther name
vim.opt.isfname:append '@-@'

-- keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- decrease update time
vim.opt.updatetime = 250

-- decrease mapped sequence wait time
vim.opt.timeoutlen = 500

-- configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- preview substitutions live, as you type!
-- note: noch nicht 100% überzeugt von dem Zeug
--       da es auf großen Dateien etwas laggy sein kann
vim.opt.inccommand = 'split'

-- show which line your cursor is on
vim.opt.cursorline = true

-- make a visible column at line 80
vim.opt.colorcolumn = '80'

-- minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8

-- folding
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.g.markdown_folding = 1

-- spell
vim.opt.spelllang = { 'de_20', 'en_us' }
vim.opt.spellsuggest = 'fast'

-- provider settings
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0

-- --------------------------------
-- Autocommands
-- --------------------------------

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank { higroup = 'Visual', timeout = 250 }
    end,
})

-- not incsearch preview window so that substitutions in big files are not laggy
vim.api.nvim_create_autocmd("BufReadPre", {
    callback = function()
        if vim.fn.getfsize(vim.fn.expand("%")) > 500000 then
            vim.opt_local.inccommand = ""
        end
    end,
})

-- bullets
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text", "asciidoc", "typst" },
    callback = function()
        vim.opt_local.formatoptions:append("r") -- `<CR>` in insert mode
        vim.opt_local.formatoptions:append("o") -- `o` in normal mode
        vim.opt_local.comments = {
            "b:- [ ]",                          -- tasks
            "b:- [x]",
            "b:*",                              -- unordered list
            "b:-",
            "b:1.",                             -- ordered list
        }

        -- second enter clears bullet
        vim.keymap.set("i", "<CR>", function()
            local line = vim.api.nvim_get_current_line()

            if line:match("^%s*[-*]%s*$")
                or line:match("^%s*%- %[[ x]%]%s*$")
                or line:match("^%s*1%.%s*$")
            then
                return "<Esc>0C"
            else
                return "<CR>"
            end
        end, { buffer = true, expr = true })
    end,
})

-- --------------------------------
-- Keybinds
-- --------------------------------

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- clipboard keybinds
vim.keymap.set({ 'n', 'x', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'x', 'v' }, '<leader>p', '"+y')

-- Enable spellchecking
vim.keymap.set('n', '<leader>,', function()
    if vim.wo.spell then
        vim.wo.spell = false
        print 'Spell checking turned off'
    else
        vim.wo.spell = true
        print 'Spell checking turned on'
    end
end, { desc = 'toggle spell checking' })

-- second enter clears comment
vim.keymap.set("i", "<CR>", function()
    local line = vim.api.nvim_get_current_line()

    -- detect the comment leader for this filetype
    local cs = vim.bo.commentstring -- for lua "-- %s"
    local leader = cs:match("^(.*)%%s")
    if not leader then return "<CR>" end

    -- escape Lua pattern characters in the comment leader
    local esc = leader:gsub("([^%w])", "%%%1")

    -- match a completely empty comment
    if line:match("^%s*" .. esc .. "%s*$") then
        return "<Esc>0C"
    else
        return "<CR>"
    end
end, { buffer = true, expr = true })

-- Oil short cut
vim.keymap.set("n", "<leader>n", "<cmd>Oil<CR>", { desc = "Open Oil file explorer" })

-- --------------------------------
-- Lazy
-- --------------------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)
-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        'nmac427/guess-indent.nvim',
        { 'folke/which-key.nvim',          event = 'VeryLazy' },
        { 'saghen/blink.indent',           opts = { scope = { enabled = false } } },
        { 'brianhuster/live-preview.nvim', ft = { "markdown", "asciidoc", "svg", "html" } },
        {
            'catppuccin/nvim',
            name = 'catppuccin',
            priority = 1000,
            opts = {
                flavour = 'mocha',
                transparent_background = true,
                default_integrations = false,
                integrations = {
                    blink_cmp = { style = 'bordered' },
                    blink_indent = true,
                    fidget = true,
                    fzf = true,
                    lualine = true,
                    mini = { enable = true },
                    which_key = true,
                },
            }
        },
        {
            'nvim-mini/mini.nvim',
            config = function()
                require('mini.ai').setup()
                require('mini.surround').setup()
                -- require('mini.pairs').setup()
                require('mini.align').setup()
                -- require('mini.git').setup()
                require('mini.diff').setup()
            end,
        },
        {
            "3rd/image.nvim",
            build = false, -- so that it doesn't build the lua rock
            ft = { 'markdown', 'typst' },
            opts = {
                processor = "magick_cli",
                integrations = {
                    markdown = {
                        only_render_image_at_cursor = true,          -- defaults to false
                        only_render_image_at_cursor_mode = "inline", -- "popup" or "inline", defaults to "popup"
                    }
                },
                backend = (function()
                    if vim.fn.has("macunix") == 1 then
                        return "kitty"
                    else
                        return "sixel"
                    end
                end)(),
            },
        },
        {
            "HakonHarnes/img-clip.nvim",
            opts = {},
            ft = { 'markdown' },
            keys = {
                { "<leader>i", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
            },
        },
        {
            'saghen/blink.cmp',
            dependencies = { 'rafamadriz/friendly-snippets' },
            version = '1.*',
            opts = {
                -- (Default) Only show the documentation popup when manually triggered
                -- completion = { documentation = { auto_show = false } },
                completion = { documentation = { auto_show = true } },

                sources = {
                    -- add lazydev to your completion providers
                    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                    providers = {
                        lazydev = {
                            name = "LazyDev",
                            module = "lazydev.integrations.blink",
                            -- make lazydev completions top priority (see `:h blink.cmp`)
                            score_offset = 100,
                        },
                    },
                },
            },
            opts_extend = { 'sources.default' },
        },
        {
            'stevearc/oil.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            opts = { delete_to_trash = true },
        },
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                'saghen/blink.cmp',
                'j-hui/fidget.nvim',
            },

            -- example using `opts` for defining servers
            opts = {
                servers = {
                    gopls = {
                        settings = {
                            gopls = {
                                completeUnimported = true,
                                usePlaceholders = true,
                            },
                        },
                    },
                    rust_analyzer = {
                        settings = {
                            ['rust_analyzer'] = {
                                cargo = {
                                    allFeatures = true,
                                },
                            },
                        },
                    },
                }
            },
            config = function()
                vim.api.nvim_create_autocmd('LspAttach', {
                    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                    callback = function(args)
                        local map = function(keys, func, desc, mode)
                            mode = mode or 'n'
                            vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = 'LSP: ' .. desc })
                        end

                        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

                        -- goto
                        map('gd', vim.lsp.buf.definition, 'goto definition')
                        map('gD', vim.lsp.buf.declaration, 'goto declaration')

                        -- Info
                        map('<C-k>', vim.lsp.buf.signature_help, 'signature help')

                        -- Diagnostics
                        map('<leader>d', vim.diagnostic.open_float, 'show line diagnostics')
                        map('<leader>q', vim.diagnostic.setloclist, 'open quickfix list')


                        -- Inlay Hints
                        if client and client:supports_method 'textDocument/inlayHint' then
                            map('<leader>#', function()
                                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = args.buf })
                            end, 'toggle inlay hints')
                        end
                    end,
                })

                require("fidget").setup {
                    notification = {
                        window = {
                            winblend = 0,
                        },
                    },
                }

                vim.notify = require("fidget").notify


                vim.lsp.enable({
                    'marksman',
                    'jdtls',
                    'ruff',
                    'pyright',
                    'bashls',
                    'lua_ls',
                    'clangd',
                    'gopls',
                    'hls',
                    'rust_analyzer',
                    'fish_lsp',
                })
            end
        },
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        {
            'ibhagwan/fzf-lua',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            cmd = { 'FzfLua' },
            keys = {
                {
                    '<leader>f',
                    '<cmd>FzfLua files<cr>',
                    mode = 'n',
                    desc = 'fuzzy find files in cwd',
                },
                {
                    '<leader>g',
                    '<cmd>FzfLua live_grep<cr>',
                    mode = 'n',
                    desc = 'fuzzy grep search in cwd',
                },
            },
        },
        {
            'nvim-lualine/lualine.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            priority = 999,
            lazy = false,
            opts = {
                options = {
                    theme = 'catppuccin',
                    component_separators = { left = '|', right = '|' },
                    section_separators = { left = '', right = '' },
                },
            },
        },
        {
            "nvim-treesitter/nvim-treesitter",
            branch = 'master',
            lazy = false,
            build = ":TSUpdate",
            dependencies = {
                'nvim-treesitter/nvim-treesitter-textobjects',
            },
            opts = {
                ensure_installed = {
                    'bash',
                    'bibtex',
                    'c',
                    'cpp',
                    'dockerfile',
                    'fish',
                    'go',
                    'html',
                    'java',
                    'json',
                    'jsonc',
                    'latex',
                    'javascript',
                    'lua',
                    'make',
                    'markdown',
                    'markdown_inline',
                    'python',
                    'query',
                    'rust',
                    'toml',
                    'vim',
                    'vimdoc',
                    'yaml',
                },
                highlight        = { enable = true },
                indent           = { enable = true },
                textobjects      = {
                    select = {
                        enable = true,
                        lookahead = true, -- jump to the next text object
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["al"] = "@loop.outer",
                            ["il"] = "@loop.inner",
                        },
                        include_surrounding_whitespace = true,
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]c"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[c"] = "@class.outer",
                        },
                    },
                },
            },
            config = function(_, opts)
                require("nvim-treesitter.configs").setup(opts)
            end,
        },
        {
            'stevearc/conform.nvim',
            event = { 'BufWritePre' },
            cmd = { 'ConformInfo' },
            keys = {
                {
                    '<leader>F',
                    function()
                        require('conform').format { async = true, lsp_format = 'fallback' }
                    end,
                    mode = '',
                    desc = 'Format buffer',
                },
            },
            opts = {
                notify_on_error = true,
                format_on_save = function()
                    return {
                        timeout_ms = 2000,
                        lsp_format = 'fallback',
                    }
                end,

                -- langs that work via lsp:
                -- rust   = rust_analyzer
                -- go     = gopls
                -- java   = jdtls
                -- c      = clangd
                -- python = ruff
                -- lua    = lua_ls

                formatters_by_ft = {
                    haskell         = { "ormolu" },

                    markdown        = { "prettierd" },
                    javascript      = { "prettierd" },
                    javascriptreact = { "prettierd" },
                    typescript      = { "prettierd" },
                    typescriptreact = { "prettierd" },
                    css             = { "prettierd" },
                    scss            = { "prettierd" },
                    less            = { "prettierd" },
                    html            = { "prettierd" },
                    json            = { "prettierd" },
                    jsonc           = { "prettierd" },
                    yaml            = { "prettierd" },
                    mdx             = { "prettierd" },
                    graphql         = { "prettierd" },
                    vue             = { "prettierd" },
                    svelte          = { "prettierd" },
                    astro           = { "prettierd" },
                },
            },
        },
    },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

-- folding autocommand
-- needs to be after lazy to ensure treesitter is installed
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "*",
    callback = function()
        -- check if treesitter has parser
        if require("nvim-treesitter.parsers").has_parser() then
            -- use treesitter folding
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        else
            -- use alternative foldmethod
            vim.opt.foldmethod = "syntax"
        end
    end,
})

-- --------------------------------
-- Color theme
-- --------------------------------


vim.cmd.colorscheme 'catppuccin'

-- :h highlight-groups
vim.cmd.hi 'Comment gui=italic'

vim.cmd.hi 'Constant gui=bold'
vim.cmd.hi 'String gui=italic'
vim.cmd.hi 'Character gui=bold'
vim.cmd.hi 'Number gui=none'
vim.cmd.hi 'Boolean gui=bold'

vim.cmd.hi 'Statement gui=none'
vim.cmd.hi 'Conditional gui=bold'
vim.cmd.hi 'Repeat gui=bold'
vim.cmd.hi 'Label gui=bold'
vim.cmd.hi 'Function gui=bold,italic'
vim.cmd.hi 'Error gui=underline'
