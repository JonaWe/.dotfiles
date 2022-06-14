local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Color theme
  use 'marko-cerovac/material.nvim'

  -- C support
  use 'jackguo380/vim-lsp-cxx-highlight'

  -- status line plugin
  use 'itchyny/lightline.vim'
  use 'itchyny/vim-gitbranch'

  use 'szw/vim-maximizer'
  use 'kassio/neoterm'

  use 'xiyaowong/nvim-transparent'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {
    'nvim-telescope/telescope-fzy-native.nvim',
    run = 'make'
  }

  -- Tresitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- lsp default config
  use 'neovim/nvim-lspconfig'

  use 'tpope/vim-surround' -- motions for ", ' and html tags
  use 'tpope/vim-commentary' -- comment out code
  use 'github/copilot.vim'

  -- tmux vim navitation
  use 'christoomey/vim-tmux-navigator'

  -- Formatter
  use 'sbdchd/neoformat'

  -- Git plugins
  use 'tpope/vim-fugitive'
  --use 'vim-airline/vim-airline'
  --use 'airblade/vim-gitgutter'
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  use 'RRethy/vim-illuminate' -- highlight the current word


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
