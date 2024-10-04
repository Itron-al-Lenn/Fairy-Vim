-- [[ Auto Commands ]]

-- [[ Auto Snippets ]]
-- Reload the LuaSnip plugin if a certain filetype is opened.
-- For some reason this is necessary at the moment to make
-- autosnippets do their job ¯\_(⇀﹏↼)_/¯
-- vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
--   pattern = { '*.tex' },
--   command = 'Lazy reload LuaSnip',
-- })
