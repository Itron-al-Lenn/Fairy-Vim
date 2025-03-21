return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      picker = { enter = true },
    },
    -- stylua: ignore
    keys = {
      { "<leader>sf", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>sg", function() Snacks.picker.grep() end,  desc = "Grep" },
      { '<leader>ol', function() Snacks.lazygit() end,      desc = '[O]pen [L]azygit'},
      { "<leader>on", function() Snacks.picker.notifications(); vim.cmd.stopinsert() end, desc = "Notification History" },
      { '<leader>q',  function() Snacks.picker.diagnostics_buffer(); end, desc = 'Open diagnostic [Q]uickfix list' },
    },
  },
  {
    'folke/todo-comments.nvim',
    optional = true,
    keys = {
      {
        '<leader>st',
        function()
          Snacks.picker.todo_comments()
        end,
        desc = 'Todo',
      },
      {
        '<leader>sT',
        function()
          Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } }
        end,
        desc = 'Todo/Fix/Fixme',
      },
    },
  },
}
