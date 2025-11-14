-- --------------------------------
-- Options
-- --------------------------------

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- relative linenumbers
vim.opt.number = true
vim.opt.relativenumber = true

-- mouse only for [v]isual mode and [i]nsert mode
vim.opt.mouse = 'vi'

-- indent
local tabw = 4
vim.opt.tabstop = tabw
vim.opt.softtabstop = tabw
vim.opt.shiftwidth = tabw
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- sync clipboard between os and neovim.
--  schedule the setting after `uienter` because it can increase startup-time.
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

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
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank { higroup = 'Visual', timeout = 250 }
    end,
})

-- Spell-checking in specific FileTypes by default
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "markdown", "text" },
    callback = function()
        vim.opt_local.spell = true
    end,
})

-- not incsearch preview window so that searching in big files is not laggy
vim.api.nvim_create_autocmd("BufReadPre", {
    callback = function()
        if vim.fn.getfsize(vim.fn.expand("%")) > 500000 then
            vim.opt_local.inccommand = ""
        end
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

-- Netrw short cut
-- vim.keymap.set('n', '<leader>n', "<cmd>Explore<CR>", { desc = 'Open Netrw' })

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
        'tpope/vim-sleuth',        -- automatically adjust tabwidth for different files
        'lewis6991/gitsigns.nvim', -- add gitsigns
        {
            "3rd/image.nvim",
            build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
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
            event = "VeryLazy",
            opts = {},
            keys = {
                { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
            },
        },
        {
            'saghen/blink.cmp',
            -- optional: provides snippets for the snippet source
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
            opts = { delete_to_trash = false },
            dependencies = { { "nvim-mini/mini.icons", opts = {} } },
            lazy = false,
        },
        {
            'j-hui/fidget.nvim',
            opts = {
                notification = {
                    window = {
                        winblend = 0,
                    },
                },
            },
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
                --  This function gets run when an LSP attaches to a particular buffer.
                --    That is to say, every time a new file is opened that is associated with
                --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
                --    function will be executed to configure the current buffer
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
                        map('K', vim.lsp.buf.hover, 'hover documentation')
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
            'bullets-vim/bullets.vim',
            ft = { 'markdown', 'text' },
            config = function()
                -- vim.g.bullets_outline_levels = { 'ROM', 'ABC', 'num', 'abc', 'rom', 'std-', 'std*', 'std+' }
                vim.g.bullets_outline_levels = { 'ROM', 'ABC', 'num', 'abc', 'rom', 'std-' }
            end,
        },
        {
            'catppuccin/nvim',
            name = 'catppuccin',
            priority = 1000, -- Make sure to load this before all the other start plugins.
            init = function()
                require('catppuccin').setup {
                    flavour = 'mocha',
                    transparent_background = true,
                    float = {
                        transparent = false, -- enable transparent floating windows
                        solid = false,       -- use solid styling for floating windows, see |winborder|
                    },
                    auto_integrations = true,
                    integrations = {
                        blink_cmp = {
                            style = 'bordered',
                        },
                        indent_blankline = {
                            enabled = true,
                            scope_color = 'surface1', -- catppuccin color (eg. `lavender`) Default: text
                            colored_indent_levels = true,
                        },
                        mini = {
                            enabled = true,
                            indentscope_color = '',
                        },
                    },
                }
                vim.cmd.colorscheme 'catppuccin'

                -- hard-coded styles
                -- :h highlight-groups
                -- You can configure highlights by doing something like:
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
            end,
        },
        {
            'ibhagwan/fzf-lua',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            -- or if using mini.icons/mini.nvim
            -- dependencies = { "echasnovski/mini.icons" },
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
            config = function()
                require('fzf-lua').setup {
                    winopts = {
                        height = 0.8,
                        width = 0.9,
                    },
                    files = {
                        previewer = true,
                    },
                }
            end,
        },
        { -- Add indentation guides even on blank lines
            'lukas-reineke/indent-blankline.nvim',
            main = 'ibl',
            opts = {
                scope = { enabled = false },
                exclude = {
                    filetypes = {
                        'lazy',
                        'lazyterm',
                    }
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
                    icons_enabled = true,
                    component_separators = { left = '|', right = '|' },
                    section_separators = { left = '', right = '' },
                },
            },
        },
        'brianhuster/live-preview.nvim',
        {
            'echasnovski/mini.nvim',
            config = function()
                require('mini.ai').setup { n_lines = 500 }
                require('mini.surround').setup()
                require('mini.pairs').setup()
                require('mini.align').setup()
            end,
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
                ensure_installed      = {
                    'bash',
                    'bibtex',
                    'c',
                    'cpp',
                    'diff',
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
                    'luadoc',
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
                highlight             = { enable = true },
                indent                = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        node_decremental = "<bs>",
                    },
                },
                textobjects           = {
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
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>sa"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>sA"] = "@parameter.inner",
                        },
                    },
                },
            },
            config = function(_, opts)
                require("nvim-treesitter.configs").setup(opts)
            end,
        },
        {
            'folke/which-key.nvim',
            event = 'VimEnter',
            opts = {
                delay = 300,
                spec = {
                    { '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } },
                },
            },
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
                    desc = '[F]ormat buffer',
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
                    haskell = { "ormolu" },

                    markdown = { "prettierd" },
                    javascript = { "prettierd" },
                    javascriptreact = { "prettierd" },
                    typescript = { "prettierd" },
                    typescriptreact = { "prettierd" },
                    css = { "prettierd" },
                    scss = { "prettierd" },
                    less = { "prettierd" },
                    html = { "prettierd" },
                    json = { "prettierd" },
                    jsonc = { "prettierd" },
                    yaml = { "prettierd" },
                    mdx = { "prettierd" },
                    graphql = { "prettierd" },
                    vue = { "prettierd" },
                    svelte = { "prettierd" },
                    astro = { "prettierd" },
                },
            },
        },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

vim.api.nvim_create_autocmd(
    "VimEnter", {
        callback = function()
            require("lazy").update({ show = false })
        end
    }
)

-- folding autocommand
-- needs to be after lazy to ensure that treesitter is installed
vim.api.nvim_create_autocmd({ "FileType" }, {
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
