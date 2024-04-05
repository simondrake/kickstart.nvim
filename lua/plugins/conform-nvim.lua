return {
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        json = { 'prettier' },
        markdown = { 'prettier' },
        sh = { 'shfmt', 'shellharden' },
        yaml = { 'prettier' },
        javascript = { { 'prettierd', 'prettier' } },
        -- Use the "*" filetype to run formatters on all filetypes.
        ['*'] = { 'codespell', 'trim_whitespace' },
      },
    },
  },
}
