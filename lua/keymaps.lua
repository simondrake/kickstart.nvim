-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>k', function()
  pcall(vim.cmd, 'cnext')
end)

vim.keymap.set('n', '<leader>j', function()
  pcall(vim.cmd, 'cprevious')
end)

vim.keymap.set('v', '<C-y>', function()
  require('decorated_yank').decorated_yank_with_link()
end)

vim.keymap.set('n', 'TE', function()
  require('toggle_export').ToggleExport()
end)

vim.keymap.set('n', '<leader>sd', function()
  require('telescope.builtin').diagnostics {
    severity = vim.diagnostic.severity.ERROR,
    file_ignore_patterns = { '%_test.go' },
  }
end)

vim.keymap.set('n', '<leader>sda', function()
  require('telescope.builtin').diagnostics {
    severity = vim.diagnostic.severity.ERROR,
  }
end)

-- Find references for the word under your cursor.
-- exclude test files
vim.keymap.set('n', 'gr', function()
  require('telescope.builtin').lsp_references {
    file_ignore_patterns = { '%_test.go' },
    include_declaration = true,
    show_line = false,
  }
end)

-- don't exclude test files
vim.keymap.set('n', 'gra', function()
  require('telescope.builtin').lsp_references {
    include_declaration = true,
    show_line = false,
  }
end)

-- search the current directory
vim.keymap.set('n', 'gd', function()
  require('telescope.builtin').lsp_definitions {
    show_line = false,
    -- jump_type = 'vsplit',
  }
end)

-- Find files
vim.keymap.set('n', '<leader>ff', function()
  require('telescope.builtin').find_files {
    find_command = { 'ag', '--follow', '--files-with-matches', '--ignore-case', '--skip-vcs-ignore', '--hidden', '--ignore', '.git' },
  }
end)
-- File files in current directory
vim.keymap.set('n', '<leader>fd', function()
  require('telescope.builtin').find_files {
    find_command = { 'ag', '--files-with-matches', '--ignore-case', '--skip-vcs-ignore', '--hidden', '--ignore', '.git' },
    cwd = require('telescope.utils').buffer_dir(),
  }
end)

vim.keymap.set('n', '`t', function()
  vim.cmd 'e ~/todo.md'
end)
vim.keymap.set('n', '`n', function()
  vim.cmd 'e ~/notes.md'
end)
vim.keymap.set('n', '`j', function()
  vim.cmd 'e ~/journal.md'
end)
