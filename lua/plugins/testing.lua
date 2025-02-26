return {
  -- [[ testing ]]
  -- These may be deleted or may be moved to a proper section where they will have a home forever
  -- or, at least, until they outlive their usefulness

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    'Bekaboo/dropbar.nvim',
    -- dev = true,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      bar = {
        enable = function(buf, win, _)
          local ft = vim.bo[buf].ft

          if
            not vim.api.nvim_buf_is_valid(buf)
            or not vim.api.nvim_win_is_valid(win)
            or vim.fn.win_gettype(win) ~= ''
            or vim.wo[win].winbar ~= ''
            or ft == 'help'
            or ft == 'noice'
            or ft == 'dashboard'
          then
            return false
          end

          local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
          if stat and stat.size > 1024 * 1024 then
            return false
          end

          return true
        end,
      },
      sources = {
        path = {
          max_depth = 16,
        },
        -- treesitter = {
        --     max_depth = 0,
        -- },
        -- lsp = {
        --     max_depth = 0,
        -- },
        -- markdown = {
        --     max_depth = 0,
        -- },
        -- terminal = {
        --     show_current = false,
        -- },
      },
    },
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup {
        signs = {
          left = '',
          right = '',
          diag = '●',
          arrow = '    ',
          up_arrow = '    ',
          vertical = ' │',
          vertical_end = ' └',
        },
        hi = {
          error = 'DiagnosticError',
          warn = 'DiagnosticWarn',
          info = 'DiagnosticInfo',
          hint = 'DiagnosticHint',
          arrow = 'NonText',
          background = 'CursorLine', -- Can be a highlight or a hexadecimal color (#RRGGBB)
          mixing_color = 'None', -- Can be None or a hexadecimal color (#RRGGBB). Used to blend the background color with the diagnostic background color with another color.
        },
        blend = {
          factor = 0.27,
        },
        options = {
          -- Show the source of the diagnostic.
          -- default: false
          show_source = true,

          -- Throttle the update of the diagnostic when moving cursor, in milliseconds.
          -- You can increase it if you have performance issues.
          -- Or set it to 0 to have better visuals.
          -- default: 20
          throttle = 0,

          -- The minimum length of the message, otherwise it will be on a new line.
          softwrap = 30,

          -- If multiple diagnostics are under the cursor, display all of them.
          -- default: false
          multiple_diag_under_cursor = false,

          -- Enable diagnostic message on all lines.
          -- default: false
          multilines = true,

          -- Show all diagnostics on the cursor line.
          show_all_diags_on_cursorline = false,

          -- Enable diagnostics on Insert mode. You should also se the `throttle` option to 0, as some artefacts may appear.
          enable_on_insert = false,

          overflow = {
            -- Manage the overflow of the message.
            --    - wrap: when the message is too long, it is then displayed on multiple lines.
            --    - none: the message will not be truncated.
            --    - oneline: message will be displayed entirely on one line.
            mode = 'wrap',
          },

          -- Format the diagnostic message.
          -- Example:
          -- format = function(diagnostic)
          --     return diagnostic.message .. " [" .. diagnostic.source .. "]"
          -- end,
          format = nil,

          --- Enable it if you want to always have message with `after` characters length.
          break_line = {
            enabled = false,
            after = 30,
          },

          virt_texts = {
            priority = 2048,
          },

          -- Filter by severity.
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },

          -- Overwrite events to attach to a buffer. You should not change it, but if the plugin
          -- does not works in your configuration, you may try to tweak it.
          overwrite_events = nil,
        },
      }
    end,
  },
}
