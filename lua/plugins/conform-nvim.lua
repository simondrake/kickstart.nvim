return {
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_format = disable_filetypes[vim.bo[bufnr].filetype] and 'never' or 'fallback',
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        json = { 'prettier' },
        markdown = { 'prettier' },
        sh = { 'shfmt', 'shellharden' },
        yaml = { 'prettier' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        -- Use the "*" filetype to run formatters on all filetypes.
        ['*'] = { 'codespell', 'trim_whitespace' },
      },
    },
  },
}
