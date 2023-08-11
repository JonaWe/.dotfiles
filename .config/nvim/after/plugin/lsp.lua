require("neodev").setup({})

local servers = {
    'pyright',
    'clangd',
    'volar',
    'lua_ls',
    'rust_analyzer',
    'jdtls',
    'tsserver',
    'tailwindcss',
    'svelte',
    'eslint',
    'cssmodules_ls',
    'kotlin_language_server',
}


require('mason').setup()
require('mason-lspconfig').setup({
    automatic_installation = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.diagnostic.config({
    virtual_text = {
        source = 'if_many',
        prefix = '',
        format = function(diagnostic)
            if diagnostic.severity == vim.diagnostic.severity.ERROR then
                return string.format("%s %s", signs.Error, diagnostic.message)
            end
            if diagnostic.severity == vim.diagnostic.severity.WARN then
                return string.format("%s %s", signs.Warn, diagnostic.message)
            end
            if diagnostic.severity == vim.diagnostic.severity.HINT then
                return string.format("%s %s", signs.Hint, diagnostic.message)
            end
            if diagnostic.severity == vim.diagnostic.severity.INFO then
                return string.format("%s %s", signs.Info, diagnostic.message)
            end
            return diagnostic.message
        end

    }
})

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>od', vim.diagnostic.open_float, opts)
--vim.keymap.set("n", "<leader>dp", require("lspsaga.diagnostic").goto_prev, opts)
--vim.keymap.set("n", "<leader>dn", require("lspsaga.diagnostic").goto_next, opts)

vim.keymap.set('n', '<space>ol', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    if client.name == 'flow' then
        for i, server in ipairs(vim.lsp.get_active_clients()) do
            if server.name == 'tsserver' then
                vim.lsp.get_client_by_id(server.id).stop()
            end
        end
    end
    if client.name == 'tsserver' then
        for i, server in ipairs(vim.lsp.get_active_clients()) do
            if server.name == 'flow' then
                vim.lsp.get_client_by_id(client.id).stop()
            end
        end
    end
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    -- vim.keymap.set('n', 'K', require('lspsaga.hover').render_hover_doc, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    --vim.keymap.set('n', '<space>wl', function()
    --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --end, bufopts)
    vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.get, bufopts)

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    -- vim.keymap.set('n', '<leader>rn', require('lspsaga.rename').lsp_rename, bufopts)
    -- vim.keymap.set('n', '<leader>p', require('lspsaga.definition').preview_definition, bufopts)

    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    -- vim.keymap.set('n', '<leader>ca', require('lspsaga.codeaction').code_action, bufopts)

    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- vim.keymap.set('n', '<leader>gr', require('lspsaga.finder').lsp_finder, bufopts)

    vim.keymap.set('n', '<leader>p', vim.lsp.buf.format, bufopts)
end

local lsp_flags = {
    debounce_text_changes = 150,
}

local lspconfig = require('lspconfig')


-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
    })
end

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace"
            }
        }
    }
})

