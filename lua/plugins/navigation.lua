return {
  {
    -- better-escape - makes jk more smooth
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup()
    end,
  },
  {
    -- arrow - allows for jumping between marked files
    'otavioschwanck/arrow.nvim',
    opts = {
      show_icons = true,
      leader_key = ';', -- Recommended to be a single key
      buffer_leader_key = 'm', -- Per Buffer Mappings
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
    {
      'alexghergh/nvim-tmux-navigation',
      opts = {
        disable_when_zoomed = true,
        keybindings = {
          left = '<C-h>',
          down = '<C-j>',
          up = '<C-k>',
          right = '<C-l>',
          last_active = '<C-\\>',
          next = '<C-Space>',
        },
      },
    },
  },
}
