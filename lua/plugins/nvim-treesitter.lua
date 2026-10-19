return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      -- Upstream tree-sitter-go is unmaintained and does not parse Go 1.26's
      -- new(value) builtin, which produces an ERROR node that cascades over the
      -- rest of the file (wrong highlights + phantom indent). This fork adds
      -- new(value) support. Pinned for reproducibility; bump to track updates.
      --
      -- install()/update() call reload_parsers(), which re-requires the parsers
      -- module (discarding any one-time mutation) and fires the User TSUpdate
      -- event. Re-applying the override on that event keeps it in effect across
      -- every :TSInstall/:TSUpdate.
      local function override_go_parser()
        require('nvim-treesitter.parsers').go.install_info = {
          url = 'https://github.com/alienvspredator/tree-sitter-go',
          revision = 'c42d459269cfd7c7723883ea06efd426217715a4',
        }
      end
      override_go_parser()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'TSUpdate',
        callback = override_go_parser,
      })

      require('nvim-treesitter').install {
        'bash',
        'c',
        'dockerfile',
        'git_config',
        'git_rebase',
        'gitcommit',
        'gitignore',
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
        'helm',
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
