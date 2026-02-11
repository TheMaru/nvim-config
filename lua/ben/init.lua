vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'

vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'

vim.o.updatetime = 50

vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.termguicolors = true

vim.opt.swapfile = true
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.colorcolumn = '120'
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'go', 'typescript', 'python' },
  callback = function()
    vim.wo.colorcolumn = '120'
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'yaml' },
  callback = function()
    vim.wo.colorcolumn = '80'
  end,
})

vim.o.scrolloff = 10

vim.o.confirm = true

vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require 'ben.remap'
require 'ben.autocommand'
require 'ben.lazy'
