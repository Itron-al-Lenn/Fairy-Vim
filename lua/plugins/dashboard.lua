return {
  'nvimdev/dashboard-nvim',
  lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
  dependencies = {
    'Itron-al-Lenn/fortune.nvim',
  },
  opts = function()
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

    logo = string.rep('\n', 8) .. logo .. '\n\n'

    local opts = {
      theme = 'doom',
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, '\n'),
        center = {
          { action = 'Telescope find_files hidden=true', desc = ' Find Files', icon = ' ', key = 'f' },
          { action = 'Telescope oldfiles hidden=true', desc = ' Recent Files', icon = ' ', key = 'r' },
          { action = '<CMD>Oil<CR>', desc = ' Open in Oil', icon = ' ', key = 'o' },
          { action = 'Telescope find_files hidden=true search_dirs=' .. vim.fn.stdpath 'config', desc = ' Config', icon = ' ', key = 'c' },
          { action = 'cd ' .. vim.fn.stdpath 'config' .. '/lua/plugins | ene | startinsert', desc = ' New Plugin', icon = ' ', key = 'C' },
          { action = 'Lazy', desc = ' Lazy', icon = '󰒲 ', key = 'l' },
          {
            action = function()
              vim.api.nvim_input '<cmd>qa<cr>'
            end,
            desc = ' Quit',
            icon = ' ',
            key = 'q',
          },
        },
        footer = require('fortune').get_fortune(),
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
      button.key_format = '  %s'
    end

    -- open dashboard after closing lazy
    if vim.o.filetype == 'lazy' then
      vim.api.nvim_create_autocmd('WinClosed', {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds('UIEnter', { group = 'dashboard' })
          end)
        end,
      })
    end

    -- change the color of the header
    vim.api.nvim_set_hl(0, 'DashboardHeader', {
      fg = '#cdd6f4',
    })

    return opts
  end,
}
