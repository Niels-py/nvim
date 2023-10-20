local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "mocha",
            transparent_background = true;
                integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                lualine = true,
            },
        },
        config = function()
            vim.cmd([[colorscheme catppuccin]])
        end,
    },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        lazy = false,
    },

    { 'lewis6991/gitsigns.nvim', lazy = false, opts = {}},

    { "lukas-reineke/indent-blankline.nvim", event = "BufEnter *.*", opts = {} },

    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = { "bash", "lua", "python" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        lazy = false,
        opts = {
            options = { theme = 'catppuccin' }
        },
    },

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {
                'L3MON4D3/LuaSnip',
                tag = "v2.*",
                build = "make install_jsregexp",
            },     -- Required
        },
        lazy = false,
    },

    { 'm4xshen/autoclose.nvim', lazy = false, opts = {}},

    {
        'numToStr/Comment.nvim',
        lazy = false,
        opts = {},
    },

    {
        'utilyre/barbecue.nvim',
        tag = '*',
        lazy = false,
        dependencies = {
            'SmiteshP/nvim-navic',
            'nvim-tree/nvim-web-devicons', -- optional dependency
        },
        opts = {
            theme = 'catppuccin',
        }
    },

    -- use 'tpope/vim-surround'

    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        keys = {
            { "<leader>d", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
        },
        opts = {
            view = { float = { enable = true } }
        }
    },

    {
        'iamcco/markdown-preview.nvim',
        ft = { 'markdown' },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                -- config
            }
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    },
})
