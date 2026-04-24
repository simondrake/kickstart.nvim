vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Return to last edit position when opening files
-- TODO - find a better way to center the buffer other than zz
vim.api.nvim_create_augroup('bufcheck', { clear = true })
vim.api.nvim_create_autocmd('BufReadPost', {
  group = 'bufcheck',
  pattern = '*',
  callback = function()
    if vim.fn.line '\'"' > 0 and vim.fn.line '\'"' <= vim.fn.line '$' then
      vim.fn.setpos('.', vim.fn.getpos '\'"')
      vim.cmd 'normal zz'
      vim.cmd 'silent! foldopen'
    end
  end,
})

vim.api.nvim_create_autocmd('FocusLost', {
  group = 'bufcheck',
  pattern = '*',
  callback = function()
    vim.cmd 'silent! wa'
  end,
})

-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, { pattern = { '*.txt', '*.md', '*.tex' }, command = 'setlocal spell spelllang=en_gb' })

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function(ev)
    local clients = vim.lsp.get_clients { bufnr = ev.buf, name = 'gopls' }
    if #clients == 0 then
      return
    end

    local client = clients[1]
    local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
    params.context = { only = { 'source.organizeImports' } }

    local result = client:request_sync('textDocument/codeAction', params, 2000, ev.buf)
    for _, r in pairs(result and result.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
      end
    end

    vim.lsp.buf.format { async = false, timeout_ms = 2000, bufnr = ev.buf }
  end,
})
