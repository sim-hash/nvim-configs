print("inside lsp.lua")
local lsp_zero = require('lsp-zero')


lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'tsserver', 'rust_analyzer', 'angularls','ansiblels','jdtls','golangci_lint_ls','gopls'},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})


--lsp.on_attach(function(client, bufnr)
--  local opts = {buffer = bufnr, remap = false}
--
--  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--  vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--
--
--  I think I added this a long time ago when I was setting up java. Prob these can be moved up as well.
--
--  nnoremap('gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
--  nnoremap('gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
--  nnoremap('K', vim.lsp.buf.hover, bufopts, "Hover text")
--  nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts, "Show signature")
--  nnoremap('<space>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
--  nnoremap('<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
--  nnoremap('<space>wl', function()
--    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--  end, bufopts, "List workspace folders")
--  nnoremap('<space>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
--  nnoremap('<space>rn', vim.lsp.buf.rename, bufopts, "Rename")
--  nnoremap('<space>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
--  vim.keymap.set('v', "<space>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
--    { noremap=true, silent=true, buffer=bufnr, desc = "Code actions" })
--  nnoremap('<space>f', function() vim.lsp.buf.format { async = true } end, bufopts, "Format file")
--
--end)
--
--lsp.setup()
--

vim.diagnostic.config({
    virtual_text = true
})
