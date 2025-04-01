return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      picker = { enter = true },
      notifier = { enabled = true },
      toggle = { enabled = true },
      statuscolumn = { enabled = true },
    },
    -- stylua: ignore
    keys = {
      { "<leader>sf", function() Snacks.picker.smart() end, desc = "Smart Find [F]iles" },
      { "<leader>sr", function() Snacks.picker.recent() end, desc = "[R]ecemt Files" },
      { "<leader>sg", function() Snacks.picker.grep() end,  desc = "[G]rep" },
      { '<leader>ol', function() Snacks.lazygit() end,      desc = '[O]pen [L]azygit'},
      { "<leader>on", function() Snacks.picker.notifications(); vim.cmd.stopinsert() end, desc = "[N]otification History" },
      { '<leader>q',  function() Snacks.picker.diagnostics_buffer(); end, desc = 'Open diagnostic [Q]uickfix list' },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>tL'
          Snacks.toggle.diagnostics():map '<leader>td'
          Snacks.toggle.line_number():map '<leader>tl'
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>tc'
          Snacks.toggle.treesitter():map '<leader>tT'
          Snacks.toggle.inlay_hints():map '<leader>th'
          Snacks.toggle.indent():map '<leader>tg'
          Snacks.toggle.dim():map '<leader>tD'
        end,
      })
    end,
  },
  {
    'folke/todo-comments.nvim',
    optional = true,
    --stylua: ignore
    keys = {
      { '<leader>st', function() Snacks.picker.todo_comments() end, desc = '[T]odo' },
      { '<leader>sT', function() Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } } end, desc = '[T]odo/Fix/Fixme' },
    },
  },
}
