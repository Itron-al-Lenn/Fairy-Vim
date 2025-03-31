return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  dependencies = {
    'echasnovski/mini.nvim',
    'nvim-treesitter/nvim-treesitter',
    'saghen/blink.cmp',
  },
  opts = {
    preview = {
      icon_provider = 'mini',
    },
  },
}
