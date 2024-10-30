-- Add the key mappings only for Markdown files in a zk notebook.
if require('zk.util').notebook_root(vim.fn.expand '%:p') ~= nil then
  -- Open the link under the caret.
  vim.keymap.set('n', '<CR>', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, buffer = true, silent = false, desc = 'Open wiki-link' })

  -- Create a new note after asking for its title.
  -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
  vim.keymap.set(
    'n',
    '<leader>zn',
    "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
    { noremap = true, buffer = true, silent = false, desc = '[N]ew Zettel' }
  )
  -- Create a new note in the same directory as the current buffer, using the current selection for title.
  vim.keymap.set('v', '<leader>znt', ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", { noremap = true, buffer = true, silent = false })
  -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
  vim.keymap.set(
    'v',
    '<leader>znc',
    ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
    { noremap = true, buffer = true, silent = false }
  )

  -- Open notes linking to the current buffer.
  vim.keymap.set('n', '<leader>zb', '<Cmd>ZkBacklinks<CR>', { noremap = true, buffer = true, silent = false, desc = 'Open [B]acklinks' })
  -- Open notes linked by the current buffer.
  vim.keymap.set('n', '<leader>zl', '<Cmd>ZkLinks<CR>', { noremap = true, buffer = true, silent = false, desc = 'Open [L]inks' })

  -- Preview a linked note.
  vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, buffer = true, silent = false })
  -- Open the code actions for a visual selection.
  vim.keymap.set(
    'v',
    '<leader>za',
    ":'<,'>lua vim.lsp.buf.range_code_action()<CR>",
    { noremap = true, buffer = true, silent = false, desc = 'Show Code [A]ctions for selection' }
  )
end
