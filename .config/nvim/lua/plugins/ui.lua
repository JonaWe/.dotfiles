return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { '%f' },
                lualine_x = { 'encoding', 'fileformat' },
                lualine_y = { 'filetype' },
                lualine_z = { '%l/%L:%c' }
            },
            winbar = {
                lualine_c = { 'filename', 'diagnostics' }
            },
            inactive_winbar = {
                lualine_c = { 'filename', 'diagnostics' }
            }
        }
    },
    {
        'petertriho/nvim-scrollbar',
        config = function()
            require('scrollbar').setup()
        end
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.opt.timeout = true
            vim.opt.timeoutlen = 500
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
    },
    {
        'RRethy/vim-illuminate',
        config = function ()
            require('illuminate').configure({
                providers = {
                    'lsp',
                },
                delay = 10,
            })
        end
    }
}
