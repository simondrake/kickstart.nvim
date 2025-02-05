-- Use treesitter as the source of truth for folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- enable/disable the fold column
vim.opt.foldcolumn = '0' -- '1'

-- first line of the fold will be syntax highlighted, rather than all be one colour
vim.opt.foldtext = ''
-- minimum level of a fold that will be closed by default
vim.opt.foldlevel = 99

-- what level of folds should be open by default vs closed
-- 1 means top level folds are open, but anything nested beyond that is closed
-- vim.opt.foldlevelstart = 1

-- how deeply code gets folded
vim.opt.foldnestmax = 4

-- zR : open all folds
-- zM : close all open folds
-- za : toggle the fold at the cursor
-- zk : move to previous fold
-- zj : move to next fold
