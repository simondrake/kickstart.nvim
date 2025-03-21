vim.g.mapleader = ','
vim.g.maplocalleader = ','

require 'options'
require 'folding'
require 'keymaps'
require 'autocommands'
require 'commands'
require 'plugins/lazy'
require 'filetype'

-- [[ Work ]]
pcall(function()
  return require 'work'
end)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
