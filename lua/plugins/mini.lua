return {
  {
    'echasnovski/mini.diff',
    version = false,
    config = function()
      local minidiff = require 'mini.diff'

      minidiff.setup {
        view = {
          style = 'sign',
          signs = {
            add = '+',
            change = '~',
            delete = '_',
            topdelete = '‾',
            changedelete = '~',
          },
        },
        mappings = {
          -- Apply hunks inside a visual/operator region
          apply = '',

          -- Reset hunks inside a visual/operator region
          reset = 'gH',

          -- Hunk range textobject to be used inside operator
          -- Works also in Visual mode if mapping differs from apply and reset
          textobject = '',

          -- Go to hunk range in corresponding direction
          goto_first = '',
          goto_prev = '[c',
          goto_next = ']c',
          goto_last = '',
        },

        options = {
          -- Whether to wrap around edges during hunk navigation
          wrap_goto = true,
        },
      }
    end,
  },
  {
    'echasnovski/mini.hipatterns',
    version = false,
    config = function()
      local hipatterns = require 'mini.hipatterns'

      hipatterns.setup {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
  },
  -- {
  --   'echasnovski/mini-git',
  --   version = false,
  --   main = 'mini.git',
  --   config = function()
  --     require('mini.git').setup()
  --   end,
  -- },
}
