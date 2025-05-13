-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'tpope/vim-sleuth' },

  -- [[ Git ]]
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  { 'shumphrey/fugitive-gitlab.vim' },

  -- [[ Theme]]
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },

  -- [[ Everything else ]]
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        columns = { 'icon' },
        keymaps = {
          ['<C-h>'] = false,
          ['<M-h>'] = false,
        },
        view_options = {
          show_hidden = true,
        },
      }

      -- Open parent directory in current window
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

      -- Open parent directory in floating window
      vim.keymap.set('n', '<space>-', require('oil').toggle_float)
    end,
  },
  {
    'simondrake/decorated_yank',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      domains = {
        github = {
          url = 'github.com',
          blob = '/blob/',
          line_format = '#L%s-L%s',
        },
      },
    },
  },
  { 'simondrake/toggle_export' },
  {
    'simondrake/gomodifytags',
    opts = {
      override = true,
      options = { 'json=omitempty' },
      parse = { enabled = true },
    },
  },

  require 'plugins.telescope',
  require 'plugins.conform-nvim',
  require 'plugins.nvim-lspconfig',
  require 'plugins.nvim-treesitter',
  require 'plugins.debug',
  require 'plugins.indent_line',
  require 'plugins.lint',
  require 'plugins.lualine',
  require 'plugins.mini',
  require 'plugins.blink',
  require 'plugins.ai',
  require 'plugins.testing',
  require 'plugins.localdev',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
