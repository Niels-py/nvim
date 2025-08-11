return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = {
    'LspInfo',
    'LspLog',
    'LspStart',
    'LspInstall',
    'LspUninstall',
    'Mason',
    'MasonInstall',
    'MasonLog',
    'MasonToolsClean',
    'MasonToolsInstall',
    'MasonToolsInstallSync',
    'MasonToolsUpdate',
    'MasonToolsUpdateSync',
    'MasonUninstall',
    'MasonUninstallAll',
    'MasonUpdate',
  },
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    -- Mason must be loaded before its dependents so we need to set it up here.
    -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
    { 'williamboman/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
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

    -- Allows extra capabilities provided by nvim-cmp
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map('gd', '<cmd>FzfLua lsp_definitions<cr>', '[G]oto [D]efinition')

        -- Find references for the word under your cursor.
        map('gr', '<cmd>FzfLua lsp_references<cr>', '[G]oto [R]eferences')

        -- open diagnostic in floating window (if you cannot see the whole linter output)
        map('<leader>d', vim.diagnostic.open_float, 'display [D]iagnostics')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gI', '<cmd>FzfLua lsp_implementations<cr>', '[G]oto [I]mplementation')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('<leader>D', '<cmd>FzfLua lsp_type_definitions<cr>', 'Type [D]efinition')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>s', '<cmd>FzfLua lsp_document_symbols<cr>', 'Document [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map('<leader>S', '<cmd>FzfLua lsp_dynamic_workspace_symbols<cr>', 'Workspace [S]ymbols')

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>r', vim.lsp.buf.rename, '[R]ename')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>a', vim.lsp.buf.code_action, 'code [A]ction', { 'n', 'x' })

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>#', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, 'Toggle Inlay Hints ###')
        end
      end,
    })

    -- Change diagnostic symbols in the sign column (gutter)
    local signs = {
      ERROR = '',
      WARN = '',
      INFO = '',
      HINT = '',
    }
    local diagnostic_signs = {}
    for type, icon in pairs(signs) do
      diagnostic_signs[vim.diagnostic.severity[type]] = icon
    end
    vim.diagnostic.config { signs = { text = diagnostic_signs } }

    -- set capabilities
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    require('lspconfig').lua_ls.setup { capabilities = capabilities }

    ----------------------------------------
    -- Mason and per server configs

    local servers = {
      clangd = {},
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
      ts_ls = {},
      bashls = {},
      ruff = {},
      pyright = {},
      -- hls = {},
      jdtls = {},
      marksman = {},

      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = { disable = { 'missing-fields' }, globals = { 'vim' } },
          },
        },
      },
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      -- formatter
      'stylua',
      'prettierd',
      'prettier',
      'clang-format',
      'ormolu',
      'black',
      'flake8',

      -- linter
      'markdownlint',
      'hlint',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for ts_ls)
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
