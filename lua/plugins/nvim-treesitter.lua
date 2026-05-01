return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install {
        'bash',
        'c',
        'dockerfile',
        'git_rebase',
        'go',
        'gomod',
        'gosum',
        'html',
        'json',
        'jsonnet',
        'lua',
        'make',
        'markdown',
        'proto',
        'rust',
        'terraform',
        'vim',
        'vimdoc',
        'yaml',
      }

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          if pcall(vim.treesitter.start, ev.buf) then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
