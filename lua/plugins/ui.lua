package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?/init.lua;'
package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?.lua;'

return {
  {
    -- dashboard - adds a dashboard when running nvim without argument
    'nvimdev/dashboard-nvim',
    lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
    dependencies = {
      -- fortune - adds quotes to dashboard
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
  },
  {
    -- gitsigns - adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })
        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  },
  {
    -- image - adds image support
    '3rd/image.nvim',
    ft = 'markdown',
  },
  {
    -- helpview - makes the help looks nicer
    'OXY2DEV/helpview.nvim',
  },
  {
    -- lualine - creates a status bar at the bottom
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'ColorScheme',
    config = function()
      local icons = require 'util.icons'
      require('lualine').setup {
        options = {
          theme = 'auto',
          sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch' },

            lualine_c = {
              {
                'diagnostics',
                symbols = {
                  error = icons.diagnostics.Error,
                  warn = icons.diagnostics.Warn,
                  info = icons.diagnostics.Info,
                  hint = icons.diagnostics.Hint,
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
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
            },
              {
                'diff',
                symbols = {
                  added = icons.git.added,
                  modified = icons.git.modified,
                  removed = icons.git.removed,
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
      -- add any options here
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    -- notify - adds popop to notifications
    'rcarriga/nvim-notify',
    opts = {
      stages = 'static',
      timeout = 10000,
      background_colour = '#1E1E2EFF',
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
  },
  {
    -- which-key - shows what which key does in a handy pop-up at the bottom of the screen
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      }
    end,
  },
}
