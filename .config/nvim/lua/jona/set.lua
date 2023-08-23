vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.mouse = 'a'

vim.opt.termguicolors = true
vim.o.background = 'dark'

-- vim.o.ls = 0
-- vim.o.ch = 0

-- currently doing this with lualine
-- vim.o.winbar = '%f %m'

vim.opt.relativenumber = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 50

vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.laststatus = 3

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.scrolloff = 6
vim.opt.cmdheight = 1
vim.opt.shortmess:append('c')
vim.opt.colorcolumn = '100'
vim.opt.signcolumn = "yes:2"
--vim.opt.signcolumn = 'auto:2-5'

vim.opt.spell = true
vim.opt.spelllang = 'en,de'
vim.opt.spellfile = '$HOME/neovim/spellfile/en.utf-8.add'

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
