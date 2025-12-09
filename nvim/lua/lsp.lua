-- Mason setup
require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- LSP keybindings (applied when LSP attaches to buffer)
local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
end

-- LSP capabilities (for nvim-cmp)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- Mason-lspconfig setup with handlers
require('mason-lspconfig').setup({
    ensure_installed = {},
    automatic_installation = true,
    handlers = {
        -- Default handler for all servers
        function(server_name)
            require('lspconfig')[server_name].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end,
        -- basedpyright specific config
        ['basedpyright'] = function()
            require('lspconfig').basedpyright.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    basedpyright = {
                        analysis = {
                            autoSearchPaths = true,
                            diagnosticMode = 'workspace',
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })
        end,
    },
})
