local function add_return()
  vim.api.nvim_feedkeys('n', 'n', true)

  local text_before_cursor = vim.fn.getline('.'):sub(vim.fn.col '.' - 5, vim.fn.col '.' - 1)

  if text_before_cursor ~= 'retur' then
    return
  end

  local current_line = vim.api.nvim_get_current_line():gsub('^%s*(.-)%s*$', '%1')

  -- if we've already got a return statement, don't do anything
  if current_line ~= 'retur' then
    return
  end

  local current_node = vim.treesitter.get_node()

  if not current_node then
    return
  end

  local function_node = require('treesitter_utils').find_node_ancestor({ 'function_declaration' }, current_node)

  if not function_node then
    return
  end

  local result_node = function_node:field 'result'

  if not #result_node == 1 then
    return
  end

  local result_node_text = vim.treesitter.get_node_text(result_node[1], 0)

  -- Remove paranthesis
  result_node_text = string.gsub(result_node_text, '[()]', '')
  result_node_text = string.gsub(result_node_text, '[()]', '')

  -- Replace pointers
  result_node_text = string.gsub(result_node_text, '*', '&')

  -- Replace types with actual values
  result_node_text = string.gsub(result_node_text, 'error', 'nil')

  -- Get row and column cursor
  -- use unpack because it's a tuple
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { ' ' .. result_node_text })
end

-- vim.keymap.set('i', 'n', add_return, { buffer = true })
