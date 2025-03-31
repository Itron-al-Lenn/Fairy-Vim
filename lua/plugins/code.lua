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
        lua = { 'stylua' },
        python = { 'isort', 'ruff' },
        c = { 'clang-format' },
        rust = { 'rustfmt' },
        bash = { 'shfmt' },
        json = { 'json-lsp' },
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
    -- treesitter - adds code highlighting (and a bit more...)
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
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
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
