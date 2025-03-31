local util = require 'util.util'

return {
  {
    'saecki/crates.nvim',
    tag = 'stable',
    ft = { 'rust' },
    event = { 'BufRead Cargo.toml' },
    keys = function()
      -- stylua: ignore
      util.create_autokey({
        { '<leader>ct', '<cmd>Crates toggle<cr>', { desc = '[T]oggle' } },
        { '<leader>cr', '<cmd>Crates reload<cr>', { desc = '[R]eload' } },
        { '<leader>cv', '<cmd>Crates show_versions_popup<cr>', { desc = 'Show [V]ersion Popup' } },
        { '<leader>cf', '<cmd>Crates show_features_popup<cr>', { desc = 'Show [F]eatures Popup' } },
        { '<leader>cd', '<cmd>Crates show_dependencies_popup<cr>', { desc = 'Show [D]ependencies Popup' } },
        { '<leader>cu', '<cmd>Crates update_crate<cr>', { desc = '[U]pdate Crate' } },
        { '<leader>ca', '<cmd>Crates update_all_crates<cr>', { desc = 'Update [A]ll Crates' } },
        { '<leader>cU', '<cmd>Crates upgrade_crate<cr>', { desc = '[U]pgrade Crate' } },
        { '<leader>cA', '<cmd>Crates upgrade_all_crates<cr>', { desc = 'Upgrade [A]ll Crates' } },
        { '<leader>cH', '<cmd>Crates open_homepage<cr>', { desc = 'Open [H]omepage' } },
        { '<leader>cR', '<cmd>Crates open_repository<cr>', { desc = 'Open [R]epo' } },
        { '<leader>cD', '<cmd>Crates open_documentation<cr>', { desc = 'Open [D]ocumentation' } },
        { '<leader>cC', '<cmd>Crates open_crates_io<cr>', { desc = 'Open [C]rates.io' } },
        { '<leader>cL', '<cmd>Crates open_lib_rs<cr>', { desc = 'Open [L]ib.rs' } },
      }, 'BufRead', 'Cargo.toml')
    end,
    opts = {
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    'mrcjkb/rustaceanvim',
    ft = { 'rust' },
    opts = {
      server = {
        default_settings = {
          -- rust-analyzer language server configuration
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Add clippy lints for Rust.
            checkOnSave = true,
            procMacro = {
              enable = true,
              ignored = {
                ['async-trait'] = { 'async_trait' },
                ['napi-derive'] = { 'napi' },
                ['async-recursion'] = { 'async_recursion' },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
    end,
  },
}
