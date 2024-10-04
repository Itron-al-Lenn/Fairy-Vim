return {
  {
    'lervag/vimtex',
    dependencies = {},
    event = 'BufReadPre',
    config = function()
      vim.cmd 'filetype plugin on'
      vim.g.tex_flavor = 'latex'

      local g = vim.g
      g.localleader = ','

      g.vimtex_quickfix_open_on_warning = false

      -- treesitter handles highlights
      g.vimtex_syntax_enabled = false

      -- compilation handled by LSP (texlab)
      g.vimtex_compiler_enabled = false
    end,
  },
}
