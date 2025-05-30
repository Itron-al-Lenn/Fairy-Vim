local logo = [[
    .....                         .                                                         .                        
 .H8888888x.  '`+                @88>                 ..                                   @88>                      
:888888888888x.  !               %8P      .u    .    @L                  ...     ..        %8P      ..    .     :    
8~    `"*88888888"       u        .     .d88B :@8c  9888i   .dL       :~""888h.:^"888:      .     .888: x888  x888.  
!      .  `f""""      us888u.   .@88u  ="8888f8888r `Y888k:*888.     8X   `8888X  8888>   .@88u  ~`8888~'888X`?888f` 
 ~:...-` :8L <)88: .@88 "8888" ''888E`   4888>'88"    888E  888I    X888n. 8888X  ?888>  ''888E`   X888  888X '888>  
    .   :888:>X88! 9888  9888    888E    4888> '      888E  888I    '88888 8888X   ?**h.   888E    X888  888X '888>  
 :~"88x 48888X ^`  9888  9888    888E    4888>        888E  888I      `*88 8888~ x88x.     888E    X888  888X '888>  
<  :888k'88888X    9888  9888    888E   .d888L .+     888E  888I     ..<"  88*`  88888X    888E    X888  888X '888>  
  d8888f '88888X   9888  9888    888&   ^"8888*"     x888N><888'        ..XC.    `*8888k   888&   "*88%""*88" '888!` 
 :8888!    ?8888>  "888*""888"   R888"     "Y"        "88"  888       :888888H.    `%88>   R888"    `~    "    `"`   
 X888!      8888~   ^Y"   ^Y'     ""                        88F      <  `"888888:    X"     ""                       
 '888       X88f                                           98"             %888888x.-`                               
  '%8:     .8*"                                          ./"                 ""**""                                  
     ^----~"`                                           ~`                                                           
]]

return {
  {
    'folke/snacks.nvim',
    lazy = false,
    opts = {
      dashboard = {
        preset = {
          header = logo,
          keys = {
            { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
            { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
            { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },
        sections = {
          { section = 'header', height = 16 },
          { section = 'keys', gap = 1, padding = 2 },
          {
            footer = 'The worker of the world has nothing to lose, but their chains, workers of the world unite.\n-- Kari Marx',
            width = 90,
            align = 'center',
          },
        },
      },
    },
  },
  {
    -- helpview - makes the help looks nicer
    'OXY2DEV/helpview.nvim',
  },
  {
    -- lualine - creates a status bar at the bottom
    'nvim-lualine/lualine.nvim',
    event = 'ColorScheme',
    config = function()
      require('lualine').setup {
        options = {
          theme = 'gruvbox-material',
          sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch' },

            lualine_c = {
              {
                'diagnostics',
                symbols = {
                  error = ' ',
                  warn = ' ',
                  info = ' ',
                  hint = ' ',
                },
              },
              { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
            },
            lualine_x = {
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
            },
              {
                'diff',
                symbols = {
                  added = '+',
                  modified = '~',
                  removed = '-',
                },
                source = function()
                  local gitsigns = vim.b.gitsigns_status_dict
                  if gitsigns then
                    return {
                      added = gitsigns.added,
                      modified = gitsigns.changed,
                      removed = gitsigns.removed,
                    }
                  end
                end,
              },
            },
            lualine_y = {
              { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
              { 'location', padding = { left = 0, right = 1 } },
            },
            lualine_z = {
              function()
                return ' ' .. os.date '%R'
              end,
            },
          },
        },
      }
    end,
  },
  {
    -- noice - changes how certain ui elements are displayed
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
  },
  {
    -- which-key - shows what which key does in a handy pop-up at the bottom of the screen
    'folke/which-key.nvim',
    event = 'VimEnter',
    dependencies = { 'echasnovski/mini.nvim' },
    opts = {
      preset = 'modern',
    },
    init = function()
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>o', group = '[O]pen' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
      }
    end,
  },
  {
    'uga-rosa/ccc.nvim',
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
  },
}
