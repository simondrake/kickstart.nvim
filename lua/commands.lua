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
  vim.ui.open(require('decorated_yank').blame_link_raw())
end, { nargs = 0, range = true })

vim.api.nvim_create_user_command('GBrowse', function(opts)
  require('decorated_yank').browse { line1 = opts.range > 0 and opts.line1 or nil, line2 = opts.range > 0 and opts.line2 or nil }
end, { nargs = 0, range = true })

vim.api.nvim_create_user_command('GBrowseY', function(opts)
  vim.fn.setreg('+', require('decorated_yank').browse_link_raw { line1 = opts.range > 0 and opts.line1 or nil, line2 = opts.range > 0 and opts.line2 or nil })
end, { nargs = 0, range = true })

vim.api.nvim_create_user_command('Hacker', function(_)
  vim.api.nvim_command 'color alpha-green'
end, { nargs = 0, range = true })

vim.api.nvim_create_user_command('Jq', function(opts)
  if opts.range == 0 then
    vim.api.nvim_command '%!jq .'
  else
    local s_start = vim.fn.getpos "'<"
    local s_end = vim.fn.getpos "'>"

    vim.api.nvim_command(s_start[2] .. ',' .. s_end[2] .. '%!jq .')
  end
end, { nargs = 0, range = true, desc = 'Run jq formatting' })

vim.api.nvim_create_user_command('CopyFullFilepath', function(_)
  vim.cmd "let @+=expand('%:p')"
end, { nargs = 0, range = false, desc = 'Copy current full file path to clipboard' })

vim.api.nvim_create_user_command('CopyFilepath', function(_)
  local abs = vim.fn.expand '%:p'
  local root = vim.fn.systemlist({ 'git', '-C', vim.fn.expand '%:p:h', 'rev-parse', '--show-toplevel' })[1]
  if vim.v.shell_error == 0 and root ~= nil and root ~= '' then
    -- +1 to also strip the trailing slash
    vim.fn.setreg('+', abs:sub(#root + 2))
  else
    -- not in a git repo: fall back to cwd-relative
    vim.fn.setreg('+', vim.fn.fnamemodify(abs, ':.'))
  end
end, { nargs = 0, range = false, desc = 'Copy repo-relative file path to clipboard' })
