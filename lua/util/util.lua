-- util.lua
M = {}
M.create_autokey = function(keys, event, pattern)
  vim.api.nvim_create_autocmd(event, {
    pattern = pattern or '*',
    group = vim.api.nvim_create_augroup('autokey', { clear = false }),
    callback = function(evt)
      for _, key in ipairs(keys) do
        key[3].buffer = evt.buf
        vim.keymap.set(key[3].mode or 'n', key[1], key[2], key[3])
      end
    end,
  })
end

M.get_files = function(dir)
  local handle = vim.uv.fs_scandir(dir)
  local files = {}
  if handle then
    while true do
      local name, type = vim.uv.fs_scandir_next(handle)
      if not name then
        break
      end
      if type == 'file' then
        table.insert(files, name)
      end
    end
  end
  return files
end

return M
