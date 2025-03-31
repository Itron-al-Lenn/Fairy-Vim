return {
  {
    -- mini.nvim - collection of various smaller things
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.surround').setup()

      -- Autopair for brackets, ...
      require('mini.pairs').setup()
      -- Icons
      require('mini.icons').setup()
    end,
  },
}
