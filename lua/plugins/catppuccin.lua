return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require('catppuccin').setup {
        flavor = 'mocha',
        transparent_background = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          notify = true,
          mason = true,
          neotree = true,
          noice = true,
          which_key = true,
        },
        default_integrations = true,
        highlight_overrides = {
          mocha = function(mocha)
            return {
              Comment = { fg = mocha.pink },
              LineNr = { fg = mocha.overlay0 },
              CursorLine = { bg = 'none', style = { 'underline' } },
            }
          end,
        },
      }
    end,
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'catppuccin'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
