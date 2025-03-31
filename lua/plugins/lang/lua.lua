return {
  'folke/lazydev.nvim',
  ft = 'lua',
  dependencies = {
    { 'gonstoll/wezterm-types', lazy = true, dev = true },
    { 'Bilal2453/luvit-meta', lazy = true },
  },
  opts = {
    library = {
      { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      { path = 'wezterm-types', mods = { 'wezterm' } },
      { path = 'LazyVim', words = { 'LazyVim' } },
      { path = 'snacks.nvim', words = { 'Snacks' } },
    },
  },
}
