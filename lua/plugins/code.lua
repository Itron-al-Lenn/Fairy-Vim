return {
  {
    -- conform - autoformater
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    -- stylua: ignore
    keys = {
      { '<leader>f', function() require('conform').format { async = true, lsp_fallback = true } end, desc = '[F]ormat buffer' },
    },
    opts = {
      format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
      formatters_by_ft = {
        fish = { 'fish_indent' },
        html = { 'prettierd' },
        css = { 'prettierd' },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        lua = { 'stylua' },
        python = { 'isort', 'ruff' },
        c = { 'clang-format' },
        rust = { 'rustfmt' },
        bash = { 'shfmt', 'shellcheck' },
        json = { 'json-lsp' },
        markdown = { 'prettierd', 'markdownlint-cli2', 'markdown-toc' },
        systemverilog = { 'verible' },
        yaml = { 'prettierd' },
      },
    },
  },
  {
    -- LuaSnip - Absolutly overcomplicated snippets. Mainly for LaTeX
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',
    opts = {
      enable_autosnippets = true,
      update_events = { 'TextChanged', 'TextChangedI' },
    },
    init = function()
      local lua_s_path = './lua/snippets/luasnip/'
      require('luasnip.loaders.from_lua').load { paths = lua_s_path }
      require('luasnip.loaders.from_snipmate').lazy_load { paths = './lua/snippets/snipmate' }

      vim.keymap.set(
        'n',
        '<Leader>L',
        '<Cmd>lua require("luasnip.loaders.from_lua").load({paths = "' .. lua_s_path .. '"})<CR>',
        { desc = 'Re[L]oad snippets' }
      )
    end,
  },
  {
    -- blink - engine for handling autocompletion
    'saghen/blink.cmp',
    version = '*',
    dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    opts = {
      keymap = { preset = 'super-tab' },
      snippets = { preset = 'luasnip' },
      sources = { default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline' } },
    },
  },
  {
    -- mason - installer for lsp and other tools
    'williamboman/mason.nvim',
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',

    -- No need to load the plugin—since we just want its configs, adding the
    -- it to the `runtimepath` is enough.
    lazy = true,
    init = function()
      local lspConfigPath = require('lazy.core.config').options.root .. '/nvim-lspconfig'

      -- INFO `prepend` ensures it is loaded before the user's LSP configs, so
      -- that the user's configs override nvim-lspconfig.
      vim.opt.runtimepath:prepend(lspConfigPath)
    end,
  },
  {
    -- treesitter - adds code highlighting (and a bit more...)
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'python',
          'bash',
          'rust',
          'yaml',
          'c',
          'cpp',
          'html',
          'css',
          'lua',
          'luadoc',
          'markdown',
          'markdown_inline',
          'vim',
          'vimdoc',
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
}
