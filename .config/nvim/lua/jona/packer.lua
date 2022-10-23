local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }

    use {
        'olimorris/onedarkpro.nvim',
        config = function()
            -- require('onedarkpro').load()
        end,
    }

    use {
        'folke/tokyonight.nvim',
        config = function ()
            vim.cmd[[colorscheme tokyonight-moon]]
        end
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use { 'nvim-treesitter/nvim-treesitter-context' }

    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    }

    -- Telescope
    -- use ´:checkhealth telescope´ after installation to check if everithing is set up correctly
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make' }

    use {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        'onsails/lspkind.nvim',
    }

    use {
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip'
    }

    use { 'numToStr/Comment.nvim' }
    use { 'JoosepAlviste/nvim-ts-context-commentstring' }

    use { 'christoomey/vim-tmux-navigator' }

    use {
        'glepnir/lspsaga.nvim',
        branch = 'main',
        config = function()
            local saga = require('lspsaga')

            saga.init_lsp_saga({
                code_action_lightbulb = {
                    enable = false
                }
            })
        end,
    }

    use {
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('trouble').setup {
                signs = {
                    error = '',
                    warning = '',
                    hint = '',
                    information = '',
                    other = '﫠'
                },
            }
        end
    }

    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup()
        end
    }

    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    }

    use {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup() end
    }

    use {
        'windwp/nvim-ts-autotag',
        config = function() require('nvim-ts-autotag').setup() end
    }

    -- use {
    --     'akinsho/bufferline.nvim',
    --     tag = 'v2.*',
    --     requires = 'kyazdani42/nvim-web-devicons',
    --     config = function()
    --         require('bufferline').setup({
    --             options = {
    --                 diagnostics = 'nvim_lsp',
    --                 diagnostics_indicator = function(count, level, _, _)
    --                     local icon = level:match('error') and ' ' or ' '
    --                     return ' ' .. icon  .. count
    --                 end,
    --                 right_mouse_command = 'vertical sbuffer %d'
    --             }
    --         })
    --     end
    -- }

    use {
        'petertriho/nvim-scrollbar',
        config = function()
            require('scrollbar').setup()
            require('scrollbar.handlers.search').setup()
        end
    }
    use { 'kevinhwang91/nvim-hlslens' }

    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function ()
            require("indent_blankline").setup {
                show_current_context_start = false,
                show_current_context = false,
            }
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

    use {
        'RRethy/vim-illuminate',
        config = function ()
            require('illuminate').configure({
                providers = {
                    'lsp',
                },
                delay = 10,})
            end
        }

    use { 'folke/lua-dev.nvim' }

    use {
        'simrat39/rust-tools.nvim',
        config = function ()
            local rt = require("rust-tools")
            rt.setup({
                server = {
                    on_attach = function(_, bufnr)
                        -- Hover actions
                        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                        -- Code action groups
                        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                    end,
                },
            })
        end
    }

    use {
        'rcarriga/nvim-notify',
        config = function ()
            vim.notify = require("notify")
        end
    }

    use { 'lewis6991/impatient.nvim' }




    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)


