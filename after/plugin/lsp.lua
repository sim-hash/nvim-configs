--require('mason').setup({})
--require('mason-lspconfig').setup({
--  ensure_installed = {'clangd', 'fsautocomplete', 'tsserver', 'rust_analyzer', 'angularls','ansiblels','golangci_lint_ls','gopls'},
--  handlers = {
--    lsp_zero.default_setup,
--    lua_ls = function()
--      local lua_opts = lsp_zero.nvim_lua_ls()
--      require('lspconfig').lua_ls.setup(lua_opts)
--    end,
--  }
--})
--
---- TO:DO after you press gd how to goback to previous, CTRL - O or CTRL - I
--
----lsp.on_attach(function(client, bufnr)
----  local opts = {buffer = bufnr, remap = false}
----
----  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
----  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
----  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
----  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
----  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
----  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
----  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
----  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
----  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
----  vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
----
----
----  I think I added this a long time ago when I was setting up java. Prob these can be moved up as well.
----
----  nnoremap('gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
----  nnoremap('gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
----  nnoremap('K', vim.lsp.buf.hover, bufopts, "Hover text")
----  nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts, "Show signature")
----  nnoremap('<space>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
----  nnoremap('<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
----  nnoremap('<space>wl', function()
----    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
----  end, bufopts, "List workspace folders")
----  nnoremap('<space>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
----  nnoremap('<space>rn', vim.lsp.buf.rename, bufopts, "Rename")
----  nnoremap('<space>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
----  vim.keymap.set('v', "<space>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
----    { noremap=true, silent=true, buffer=bufnr, desc = "Code actions" })
----  nnoremap('<space>f', function() vim.lsp.buf.format { async = true } end, bufopts, "Format file")
----
----end)
----
----lsp.setup()
----
--
--vim.diagnostic.config({
--    virtual_text = true
--})
--
--
--
-- Setup Mason and Mason LSP Config
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd', 'pyright', 'gopls', 'rust_analyzer', 'lua_ls'
    },
    handlers = {
        function(server_name)
            vim.lsp.config(server_name, {
                cmd = require('mason-lspconfig').get_server(server_name),
                on_attach = function(client, bufnr)
                    local opts = { buffer = bufnr, remap = false }
                    -- Key Mappings for LSP actions
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
                end
            })
            vim.lsp.enable(server_name)
        end,
    }
})

vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc' },
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})
vim.lsp.enable('lua_ls')

-- Example LSP configuration for LuaLS (lua-language-server)
vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc' },
})
vim.lsp.enable('lua_ls')

-- Example LSP configuration for Pyright
vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'setup.py', 'pyproject.toml' },
})
vim.lsp.enable('pyright')

-- Example LSP configuration for Go (gopls)
vim.lsp.config('gopls', {
    cmd = { 'gopls' },
    filetypes = { 'go' },
    root_markers = { 'go.mod' },
})
vim.lsp.enable('gopls')

-- Example LSP configuration for Rust (rust-analyzer)
vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml' },
})
vim.lsp.enable('rust_analyzer')

-- nvim-cmp setup for autocompletion
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})

-- Diagnostics configuration
vim.diagnostic.config({
    virtual_text = true,   -- Display inline diagnostics
    signs = true,          -- Enable signs for diagnostics
    update_in_insert = true, -- Update diagnostics in insert mode
    underline = true,      -- Underline diagnostics
})

-- For handling LSP diagnostics in insert mode
