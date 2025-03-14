return {
  -- {
  --   'github/copilot.vim',
  --   cmd = 'Copilot',
  --   event = 'BufWinEnter',
  -- },
  -- {
  --   'saghen/blink.cmp',
  --   dependencies = { 'fang2hou/blink-copilot' },
  --   opts = {
  --     sources = {
  --       default = { 'copilot' },
  --       providers = {
  --         copilot = {
  --           name = 'copilot',
  --           module = 'blink-copilot',
  --           score_offset = 100,
  --           async = true,
  --         },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   'github/copilot.vim',
  --   cmd = 'Copilot',
  --   event = 'BufWinEnter',
  --   init = function()
  --     vim.g.copilot_no_maps = true
  --   end,
  --   config = function()
  --     -- Block the normal Copilot suggestions
  --     vim.api.nvim_create_augroup('github_copilot', { clear = true })
  --     vim.api.nvim_create_autocmd({ 'FileType', 'BufUnload', 'BufEnter' }, {
  --       group = 'github_copilot',
  --       callback = function(args)
  --         vim.fn['copilot#On' .. args.event]()
  --       end,
  --     })
  --   end,
  -- },
  {
    'saghen/blink.cmp',
    dependencies = {
      'fang2hou/blink-copilot',
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        -- Custom snippets
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load { paths = '~/.config/nvim/my_snippets' }
        end,
      },
      'xzbdmw/colorful-menu.nvim',
    },

    -- use a release tag to download pre-built binaries
    version = '*',
    opts = {
      enabled = function()
        local filetype = vim.bo[0].filetype
        if filetype == 'TelescopePrompt' or filetype == 'minifiles' or filetype == 'snacks_picker_input' then
          return false
        end
        return true
      end,

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        -- providers = {
        --   copilot = {
        --     name = 'copilot',
        --     module = 'blink-copilot',
        --     score_offset = 100,
        --     async = true,
        --   },
        -- },
      },
      cmdline = {},

      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        preset = 'enter',

        ['<Tab>'] = {},
        ['<C-space>'] = {
          function(cmp)
            cmp.show { providers = { 'snippets' } }
          end,
        },
      },

      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { 'lsp' },
            columns = { { 'kind_icon', 'label', gap = 1 }, { 'kind' } },
            components = {
              label = {
                text = function(ctx)
                  return require('colorful-menu').blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require('colorful-menu').blink_components_highlight(ctx)
                end,
              },
            },
          },
        },

        -- 'prefix' will fuzzy match on the text before the cursor
        -- 'full' will fuzzy match on the text before *and* after the cursor
        -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
        keyword = { range = 'full' },

        -- Show documentation when selecting a completion item
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },

        -- Display a preview of the selected item on the current line
        ghost_text = { enabled = false },
      },

      -- experimental signature help support
      signature = { enabled = true },

      appearance = {
        nerd_font_variant = 'mono',
      },

      snippets = { preset = 'luasnip' },
    },
    opts_extend = { 'sources.default' },
  },
}
