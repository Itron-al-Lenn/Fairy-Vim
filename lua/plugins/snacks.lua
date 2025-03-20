return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    keys = {
      {
        '<leader>ol',
        function()
          Snacks.lazygit()
        end,
        desc = '[O]pen [L]azygit',
      },
    },
  },
}
