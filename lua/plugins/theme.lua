local overrides = require('util.colours').current_colours

return {
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  -- Theme - Based on catppuccin but overrideswith the colours defined in util.colours
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavor = 'mocha',
        transparent_background = not vim.g.neovide,
        integrations = {
          blink_cmp = true,
          mason = true,
          noice = true,
          snacks = { enabled = true },
          which_key = true,
        },
        default_integrations = true,
        color_overrides = {
          mocha = { -- custom
            rosewater = overrides['rosewater'] or '#ffc6be',
            flamingo = overrides['flamingo'] or '#fb4934',
            pink = overrides['pink'] or '#ff75a0',
            mauve = overrides['mauve'] or '#f2594b',
            red = overrides['red'] or '#f2594b',
            maroon = overrides['maroon'] or '#fe8019',
            peach = overrides['peach'] or '#FFAD7D',
            yellow = overrides['yellow'] or '#e9b143',
            green = overrides['green'] or '#b0b846',
            teal = overrides['teal'] or '#8bba7f',
            sky = overrides['sky'] or '#7daea3',
            sapphire = overrides['sapphire'] or '#689d6a',
            blue = overrides['blue'] or '#80aa9e',
            lavender = overrides['lavender'] or '#e2cca9',
            text = overrides['text'] or '#e2cca9',
            subtext1 = overrides['subtext1'] or '#e2cca9',
            subtext0 = overrides['subtext0'] or '#e2cca9',
            overlay2 = overrides['overlay2'] or '#8C7A58',
            overlay1 = overrides['overlay1'] or '#735F3F',
            overlay0 = overrides['overlay0'] or '#806234',
            surface2 = overrides['surface2'] or '#665c54',
            surface1 = overrides['surface1'] or '#3c3836',
            surface0 = overrides['surface0'] or '#32302f',
            base = overrides['base'] or '#282828',
            mantle = overrides['mantle'] or '#1d2021',
            crust = overrides['crust'] or '#1b1b1b',
          },
        },
        styles = {
          comments = { 'italic' },
          functions = { 'bold' },
        },
        highlight_overrides = {
          mocha = function(mocha)
            return {
              LineNr = { fg = mocha.overlay1 },
              CursorLine = { bg = 'none', style = { 'underline' } },
              SnacksDashboardHeader = { fg = mocha.text },
              NoiceCmdlineIcon = { link = 'SnacksPickerIcon' },
            }
          end,
        },
      }
    end,
  },
}
