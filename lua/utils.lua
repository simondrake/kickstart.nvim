local M = {}

function M.buffer_dir()
  return vim.fn.expand '%:p:h'
end

return M
