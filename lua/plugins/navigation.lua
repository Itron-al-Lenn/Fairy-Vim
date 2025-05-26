return {
  {
    -- better-escape - makes jk more smooth
    'max397574/better-escape.nvim',
    opts = {},
  },
  {
    -- arrow - allows for jumping between marked files
    'otavioschwanck/arrow.nvim',
    opts = {
      show_icons = true,
      leader_key = ';',
      buffer_leader_key = 'm',
    },
  },
  {
    -- oil - allows to edit your file tree like a buffer
    'stevearc/oil.nvim',
    lazy = false,
    dependencies = { 'echasnovski/mini.nvim' },
    -- stylua: ignore
    keys = {
      { '-', function() require('oil').toggle_float() end, desc = 'Open parent directory' },
    },
    opts = {
      columns = { 'icon', 'size' },
      view_options = { show_hidden = true },
      keymaps = {
        ['q'] = { 'actions.close', mode = 'n' },
      },
    },
  },
  {
    -- fzf - adds fzf to nvim
    'ibhagwan/fzf-lua',
    dependencies = { 'echasnovski/mini.nvim' },
    opts = {},
  },
  {
    -- todo-comments - adds the option to navigate between todo-comments
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },
  {
    -- nvim-tmux-navigation - syncs window navigation between nvim and tmux
    'numToStr/Navigator.nvim',
    lazy = false,
    opts = {
      disable_when_zoomed = true,
      auto_save = 'current',
    },
    keys = {
      { '<C-h>', '<CMD>NavigatorLeft<CR>', desc = 'Move Focus Left' },
      { '<C-l>', '<CMD>NavigatorRight<CR>', desc = 'Move Focus Right' },
      { '<C-k>', '<CMD>NavigatorUp<CR>', desc = 'Move Focus Up' },
      { '<C-j>', '<CMD>NavigatorDown<CR>', desc = 'Move Focus Down' },
    },
  },
}
