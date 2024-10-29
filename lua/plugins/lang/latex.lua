return {
  {
    'lervag/vimtex',
    dependencies = {},
    event = 'BufReadPre',
    config = function()
      vim.cmd 'filetype plugin on'
      local g = vim.g

      g.vimtex_quickfix_open_on_warning = false

      -- treesitter handles highlights
      g.vimtex_syntax_enabled = false
    end,
  },
}
