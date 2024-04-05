vim.api.nvim_create_user_command('GoAddTags', function(opts)
  require('gomodifytags').GoAddTags(opts.fargs[1], opts.args)
end, { nargs = '+' })

vim.api.nvim_create_user_command('GoRemoveTags', function(opts)
  require('gomodifytags').GoRemoveTags(opts.fargs[1], opts.args)
end, { nargs = '+' })

vim.api.nvim_create_user_command('ToggleExport', function(_)
  require('toggle_export').ToggleExport()
end, {})
