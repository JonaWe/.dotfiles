local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
    -- use {
    --     'windwp/nvim-ts-autotag',
    --     config = function() require('nvim-ts-autotag').setup() end
    -- }
    --
    -- -- use {
    -- --     'akinsho/bufferline.nvim',
    -- --     tag = 'v2.*',
    -- --     requires = 'kyazdani42/nvim-web-devicons',
    -- --     config = function()
    -- --         require('bufferline').setup({
    -- --             options = {
    -- --                 diagnostics = 'nvim_lsp',
    -- --                 diagnostics_indicator = function(count, level, _, _)
    -- --                     local icon = level:match('error') and ' ' or ' '
    -- --                     return ' ' .. icon  .. count
    -- --                 end,
    -- --                 right_mouse_command = 'vertical sbuffer %d'
    -- --             }
    -- --         })
    -- --     end
    -- -- }
    --
    --
    --
    --
    --
    -- -- use {
    -- --     "kiyoon/jupynium.nvim",
    -- --     run = "pip3 install --user .",
    -- --     config = function ()
    -- --         require('jupynium').setup({})
    -- --     end
    -- -- }
    -- 
    -- use { 'WhiteBlackGoose/magma-nvim-goose', run = ':UpdateRemotePlugins' }
    --
    -- use { 'goerz/jupytext.vim' }


require("lazy").setup("plugins")
