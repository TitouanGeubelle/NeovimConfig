-- Set autoindentation to 4 spaces
vim.opt.tabstop = 4 -- Number of spaces a <Tab> counts for
vim.opt.shiftwidth = 4 -- Number of spaces for autoindent (>>, <<, etc.)
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.autoindent = true -- Copy indent from current line when starting a new line
vim.opt.smartindent = true -- Smart autoindent (improves on autoindent for code)
vim.opt.softtabstop = 4 -- Number of spaces for <Tab> in insert mode (backspace deletes 4 spaces)
return {}
