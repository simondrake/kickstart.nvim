vim.api.nvim_create_user_command('GoAddTags', function(opts)
  require('gomodifytags').GoAddTags(opts.fargs[1], opts.args)
end, { nargs = '+' })

vim.api.nvim_create_user_command('GoRemoveTags', function(opts)
  require('gomodifytags').GoRemoveTags(opts.fargs[1], opts.args)
end, { nargs = '+' })

vim.api.nvim_create_user_command('ToggleExport', function(_)
  require('toggle_export').ToggleExport()
end, {})

vim.api.nvim_create_user_command('Browse', function(opts)
  vim.fn.system { 'xdg-open', opts.fargs[1] }
end, { nargs = 1 })

vim.api.nvim_create_user_command('GBlame', function(_)
  require('decorated_yank').blame_link()
end, { nargs = 0, range = true })

vim.api.nvim_create_user_command('GBlameO', function(_)
  vim.fn.system { 'xdg-open', require('decorated_yank').blame_link() }
end, { nargs = 0, range = true })
