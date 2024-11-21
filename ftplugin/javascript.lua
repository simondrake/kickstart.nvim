local function add_async()
  vim.api.nvim_feedkeys('t', 'n', true)

  -- '.' is the cursors current position
  local text_before_cursor = vim.fn.getline('.'):sub(vim.fn.col '.' - 4, vim.fn.col '.' - 1)

  -- if the user hasn't typed in await - do nothing
  if text_before_cursor ~= 'awai' then
    return
  end

  -- Hint: Use :InspectTree to get a visualisation of the TS tree

  local current_node = vim.treesitter.get_node()
  local function_node = require('treesitter_utils').find_node_ancestor({ 'function_declaration' }, current_node)

  -- if no function node (i.e. nil) then return
  if not function_node then
    return
  end

  -- 0 for the current buffer
  local function_node_text = vim.treesitter.get_node_text(function_node, 0)

  -- if the function is already async, don't add it again
  if vim.startswith(function_node_text, 'async') then
    return
  end

  -- get start local of function_declaration
  local start_row, start_col = function_node:start()

  -- add async
  vim.api.nvim_buf_set_text(0, start_row, start_col, start_row, start_col, { 'async ' })
end

vim.keymap.set('i', 't', add_async, { buffer = true })
