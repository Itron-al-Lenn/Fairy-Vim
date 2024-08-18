return {
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = 'mason.nvim',
    cmd = { 'DapInstall', 'DapUninstall' },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    },
    -- mason-nvim-dap is loaded when nvim-dap loads
    config = function() end,
  },
  {
    'mfussenegger/nvim-dap',
    recommended = true,
    desc = 'Debugging support. Requires language specific adapters to be configured. (see lang extras)',

    dependencies = {
      'rcarriga/nvim-dap-ui',
      {
        'jbyuki/one-small-step-for-vimkind',
      -- stylua: ignore
      config = function()
        local dap = require("dap")
        dap.adapters.nlua = function(callback, conf)
          local adapter = {
            type = "server",
            host = conf.host or "127.0.0.1",
            port = conf.port or 8086,
          }
          if conf.start_neovim then
            local dap_run = dap.run
            dap.run = function(c)
              adapter.port = c.port
              adapter.host = c.host
            end
            require("osv").run_this()
            dap.run = dap_run
          end
          callback(adapter)
        end
        dap.configurations.lua = {
          {
            type = "nlua",
            request = "attach",
            name = "Run this file",
            start_neovim = {},
          },
          {
            type = "nlua",
            request = "attach",
            name = "Attach to running Neovim instance (port = 8086)",
            port = 8086,
          },
        }
      end,
      },
      -- virtual text for the debugger
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = {},
      },
    },

  -- stylua: ignore
  keys = {
    { "<leader>cd", "", desc = "+debug", mode = {"n", "v"} },
    { "<leader>cdB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>cdb", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>cdc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>cda", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>cdC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>cdg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>cdi", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>cdj", function() require("dap").down() end, desc = "Down" },
    { "<leader>cdk", function() require("dap").up() end, desc = "Up" },
    { "<leader>cdl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>cdo", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>cdO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>cdp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>cdr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>cds", function() require("dap").session() end, desc = "Session" },
    { "<leader>cdt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>cdw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

    config = function()
      -- load mason-nvim-dap here, after all adapters have been setup
      if LazyVim.has 'mason-nvim-dap.nvim' then
        require('mason-nvim-dap').setup(LazyVim.opts 'mason-nvim-dap.nvim')
      end

      vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == 'table' and sign or { sign }
        vim.fn.sign_define('Dap' .. name, { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] })
      end

      -- setup dap config by VsCode launch.json file
      local vscode = require 'dap.ext.vscode'
      local json = require 'plenary.json'
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end

      -- Extends dap.configurations with entries read from .vscode/launch.json
      if vim.fn.filereadable '.vscode/launch.json' then
        vscode.load_launchjs()
      end
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'nvim-neotest/nvim-nio' },
  -- stylua: ignore
  keys = {
    { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
  },
    opts = {},
    config = function(_, opts)
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup(opts)
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open {}
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close {}
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close {}
      end
    end,
  },
}
