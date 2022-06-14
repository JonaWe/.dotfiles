local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()

  -- Color theme
  use 'marko-cerovac/material.nvim'

  -- C support
  use 'jackguo380/vim-lsp-cxx-highlight'

  -- status line plugin
  --Plug 'itchyny/lightline.vim'
  --Plug 'itchyny/vim-gitbranch'

  use 'szw/vim-maximizer'
  use 'kassio/neoterm'

  use 'xiyaowong/nvim-transparent'

  -- Telescope
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'

  -- Tresitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- lsp default config
  use 'neovim/nvim-lspconfig'

  -- Vim surround plugin
  use 'tpope/vim-surround'

  -- coc
  -- Plug 'neoclide/coc.nvim', {'branch': 'release'}

  -- github copilot
  use 'github/copilot.vim'

  -- tmux vim navitation
  use 'christoomey/vim-tmux-navigator'

  -- Formatter
  use 'sbdchd/neoformat'

  -- Git plugins
  use 'tpope/vim-fugitive'
  use 'vim-airline/vim-airline'
  use 'airblade/vim-gitgutter'

  -- JS/TS Plugins
  use 'pangloss/vim-javascript'
  use 'leafgarland/typescript-vim'
  use 'peitalin/vim-jsx-typescript'
  --use 'styled-components/vim-styled-components', { 'branch': 'main' }

  use 'ThePrimeagen/vim-be-good'

  use 'RRethy/vim-illuminate'
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
