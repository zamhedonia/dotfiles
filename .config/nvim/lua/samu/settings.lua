vim.cmd.colorscheme("challenger_deep")
-- indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- line numbers
vim.opt.number = true
vim.opt.ruler = true

-- indentation behavior
vim.opt.autoindent = true
vim.opt.smartindent = true

-- syntax (always on in Neovim, but safe)
vim.cmd.syntax("enable")

-- filetype detection, plugins, indentation
vim.cmd("filetype plugin indent on")

-- concealment level (for obsidian)
vim.opt.conceallevel = 1
