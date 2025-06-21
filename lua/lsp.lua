local util = require 'util.util'

vim.lsp.config('*', {
  capabilities = { textDocument = { semanticTokens = { multilineTokenSupport = true } } },
  root_markers = { '.git' },
})

local servers = require 'lsp-servers'
for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

-- stylua: ignore
util.create_autokey({
    { 'gd', function() Snacks.picker.lsp_definitions() end, { desc = '[G]oto [D]efinition' } },
    { 'gr', function() Snacks.picker.lsp_references() end, { desc = '[G]oto [R]eferences' } },
    { 'gI', require('fzf-lua').lsp_implementations, { desc = '[G]oto [I]mplementation' } },
    { '<leader>D', require('fzf-lua').lsp_typedefs, { desc = 'Type [D]efinition' } },
    { '<leader>ds', function () Snacks.picker.lsp_symbols() end, { desc = '[D]ocument [S]ymbols' } },
    { '<leader>ws', function() Snacks.picker.lsp_workspace_symbols() end, { desc = '[W]orkspace [S]ymbols' } },
    { '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' } },
    { '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' } },
    { 'gD', function() Snacks.picker.lsp_declarations() end, { desc = '[G]oto [D]eclaration' } },
}, 'LspAttach')
