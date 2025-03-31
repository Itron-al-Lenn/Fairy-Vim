return {
  cmd = { 'taplo', 'lsp', 'stdio' },
  filetypes = { 'toml' },
  single_file_support = true,
  keys = {
    {
      'K',
      function()
        if vim.fn.expand '%:t' == 'Cargo.toml' and require('crates').popup_available() then
          require('crates').show_popup()
        else
          vim.lsp.buf.hover()
        end
      end,
      desc = 'Show Crate Documentation',
    },
  },
}
