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
  {
    'echasnovski/mini.basics',
    version = false,
    config = function()
      local minibasics = require 'mini.basics'

      minibasics.setup {
        -- Options. Set to `false` to disable.
        options = {
          -- Basic options ('number', 'ignorecase', and many more)
          basic = true,

          -- Extra UI features ('winblend', 'cmdheight=0', ...)
          extra_ui = false,

          -- Presets for window borders ('single', 'double', ...)
          win_borders = 'default',
        },

        -- Mappings. Set to `false` to disable.
        mappings = {
          -- Basic mappings (better 'jk', save with Ctrl+S, ...)
          basic = false,

          -- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
          -- Supply empty string to not create these mappings.
          option_toggle_prefix = '',

          -- Window navigation with <C-hjkl>, resize with <C-arrow>
          windows = false,

          -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
          move_with_alt = false,
        },

        -- Autocommands. Set to `false` to disable
        autocommands = {
          -- Basic autocommands (highlight on yank, start Insert in terminal, ...)
          basic = false,

          -- Set 'relativenumber' only in linewise and blockwise Visual mode
          relnum_in_visual_mode = false,
        },

        -- Whether to disable showing non-error feedback
        silent = false,
      }
    end,
  },
  {
    'echasnovski/mini.comment',
    version = false,
    config = function()
      local minicomment = require 'mini.comment'

      minicomment.setup {
        -- Options which control module behavior
        options = {
          -- Function to compute custom 'commentstring' (optional)
          custom_commentstring = nil,

          -- Whether to ignore blank lines when commenting
          ignore_blank_line = true,

          -- Whether to recognize as comment only lines without indent
          start_of_line = false,

          -- Whether to force single space inner padding for comment parts
          pad_comment_parts = true,
        },

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Toggle comment (like `gcip` - comment inner paragraph) for both
          -- Normal and Visual modes
          comment = '',

          -- Toggle comment on current line
          comment_line = 'gcc',

          -- Toggle comment on visual selection
          comment_visual = '',

          -- Define 'comment' textobject (like `dgc` - delete whole comment block)
          -- Works also in Visual mode if mapping differs from `comment_visual`
          textobject = '',
        },

        -- Hook functions to be executed at certain stage of commenting
        hooks = {
          -- Before successful commenting. Does nothing by default.
          pre = function() end,
          -- After successful commenting. Does nothing by default.
          post = function() end,
        },
      }
    end,
  },
  {
    'echasnovski/mini.indentscope',
    version = false,
    config = function()
      local miniindentscope = require 'mini.indentscope'
      miniindentscope.setup()
    end,
  },
  {
    'echasnovski/mini.pairs',
    version = false,
    config = function()
      local minipairs = require 'mini.pairs'
      minipairs.setup {
        -- In which modes mappings from this `config` should be created
        modes = { insert = true, command = false, terminal = false },

        -- Global mappings. Each right hand side should be a pair information, a
        -- table with at least these fields (see more in |MiniPairs.map|):
        -- - <action> - one of 'open', 'close', 'closeopen'.
        -- - <pair> - two character string for pair to be used.
        -- By default pair is not inserted after `\`, quotes are not recognized by
        -- `<CR>`, `'` does not insert pair after a letter.
        -- Only parts of tables can be tweaked (others will use these defaults).
        mappings = {
          ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
          ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
          ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

          [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
          [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
          ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

          ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
          ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
          ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
        },
      }
    end,
  },
}
