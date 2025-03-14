local function current_node()
  -- Only continue if treesitter has an active parser
  -- avoids the "no parser for language error"
  local buf = vim.api.nvim_get_current_buf()
  local highlighter = require 'vim.treesitter.highlighter'

  if not highlighter.active[buf] then
    return ''
  end

  local current_node = vim.treesitter.get_node()

  if not current_node then
    return ''
  end

  local expr = current_node

  while expr do
    if expr:type() == 'type_spec' or expr:type() == 'function_declaration' or expr:type() == 'method_declaration' then
      break
    end
    expr = expr:parent()
  end

  if not expr then
    return ''
  end

  if #expr:field 'name' == 0 then
    return ''
  end

  return vim.treesitter.get_node_text(expr:field('name')[1], 0)
end

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          always_show_tabline = false,
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
            current_node,
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
