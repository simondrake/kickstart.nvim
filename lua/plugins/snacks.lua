return {
  {
    'folke/snacks.nvim',
    opts = {
      -- Documentation for the picker
      -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
      picker = {
        matcher = {
          fuzzy = true, -- use fuzzy matching
          smartcase = true, -- use smartcase
          ignorecase = true, -- use ignorecase
          frecency = true, -- frecency bonus
        },
        formatters = {
          file = {
            filename_first = true, -- display filename before the file path
            truncate = 80,
          },
        },
        layout = {
          reverse = true,
          layout = {
            box = 'horizontal',
            backdrop = false,
            width = 0.8,
            height = 0.9,
            border = 'none',
            {
              box = 'vertical',
              { win = 'list', title = ' Results ', title_pos = 'center', border = 'rounded' },
              { win = 'input', height = 1, border = 'rounded', title = '{title} {live} {flags}', title_pos = 'center' },
            },
            {
              win = 'preview',
              title = '{preview:Preview}',
              width = 0.45,
              border = 'rounded',
              title_pos = 'center',
            },
          },
        },
      },
    },
    keys = {
      {
        '<leader>ff',
        function()
          Snacks.picker.files {
            finder = 'files',
            format = 'file',
            show_empty = true,
            hidden = true,
            ignored = true,
            follow = true,
            supports_live = true,
            exclude = { '.git' },
          }
        end,
        desc = '[F]ind [f]iles',
      },
      {
        '<leader>fd',
        function()
          Snacks.picker.files {
            finder = 'files',
            format = 'file',
            show_empty = true,
            hidden = true,
            ignored = true,
            follow = true,
            supports_live = true,
            exclude = { '.git' },
            dirs = { require('utils').buffer_dir() },
          }
        end,
        desc = '[Find] files in current [d]irectory',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics {
            finder = 'diagnostics',
            format = 'diagnostic',
            sort = {
              fields = {
                'is_current',
                'is_cwd',
                'severity',
                'file',
                'lnum',
              },
            },
            severity = { min = 'warn' },
            filter = {
              filter = function(item)
                -- Print contents of the 'item' table
                -- print(vim.inspect(item))
                -- print(item.file)

                if not item then
                  return true
                end

                if string.find(item.file, '%_test.go') then
                  return false
                end

                return true
              end,
            },
          }
        end,
        desc = '[S]earch [d]iagnostics',
      },
      {
        '<leader>sda',
        function()
          Snacks.picker.diagnostics {
            finder = 'diagnostics',
            format = 'diagnostic',
            sort = {
              fields = {
                'is_current',
                'is_cwd',
                'severity',
                'file',
                'lnum',
              },
            },
            severity = { min = 'warn' },
          }
        end,
        desc = '[S]earch [d]iagnostics ([a]ll)',
      },
      {
        'gr',
        function()
          Snacks.picker.lsp_references {
            finder = 'lsp_references',
            format = 'file',
            include_declaration = true,
            include_current = false,
            auto_confirm = true,
            jump = { tagstack = true, reuse_win = true },
          }
        end,
        desc = '[G]et [r]eferences',
      },
      {
        '<leader>lg',
        function()
          Snacks.picker.grep {
            finder = 'grep',
            regex = true,
            format = 'file',
            show_empty = true,
            live = true, -- live grep by default
            supports_live = true,
            hidden = true,
            ignored = true,
            follow = true,
            exclude = { '.git' },
          }
        end,
        desc = '[L]ive [g]rep',
      },
      {
        'gd',
        function()
          Snacks.picker.lsp_definitions {
            finder = 'lsp_definitions',
            format = 'file',
            include_current = false,
            auto_confirm = true,
            jump = { tagstack = true, reuse_win = true },
          }
        end,
        desc = '[G]o to [d]efinition',
      },
      {
        'gi',
        function()
          Snacks.picker.lsp_implementations {
            finder = 'lsp_implementations',
            format = 'file',
            include_current = false,
            auto_confirm = true,
            jump = { tagstack = true, reuse_win = true },
          }
        end,
        desc = '[G]o to [i]mplementation',
      },
      {
        ',,',
        function()
          Snacks.picker.buffers {
            finder = 'buffers',
            format = 'buffer',
            hidden = false,
            unloaded = true,
            current = true,
            sort_lastused = true,
          }
        end,
        desc = 'Buffers',
      },
    },
  },
}
