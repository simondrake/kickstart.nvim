return {
  {
    'SmiteshP/nvim-navic',
    requires = 'neovim/nvim-lspconfig',
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
    config = function()
      local navic = require 'nvim-navic'

      require('lualine').setup {
        options = {
          icons_enabled = true,
          disabled_filetypes = {},
        },

        sections = {
          lualine_a = {
            'mode',
          },
          lualine_b = {
            'branch',
            'diff',
          },
          lualine_c = {
            {
              'filename',
              file_status = false, -- displays file status (readonly status, modified status)
              path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
            -- function()
            --   return require('nvim-treesitter').statusline {
            --     indicator_size = 100,
            --     type_patterns = { 'class', 'function', 'method' },
            --     transform_fn = function(line, _node)
            --       return line:gsub('%s*[%[%(%{]*%s*$', '')
            --     end,
            --     separator = ' -> ',
            --   }
            -- end,
            {
              function()
                return navic.get_location()
              end,
              cond = function()
                return navic.is_available()
              end,
            },
          },
          lualine_x = { 'encoding', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },
}
