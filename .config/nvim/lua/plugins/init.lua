return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            local tokyonight = require("tokyonight")
            tokyonight.setup({ style = "moon" })
            tokyonight.load()
        end,
    },
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = { { "-", "<Cmd>Oil<CR>", "Open Oil Browser" } },
    },
    { "mbbill/undotree", keys = {
        { "<leader>u", "<cmd>UndotreeToggle<cr>", "Toggle [U]ndotree" },
    } },
    {
        "echasnovski/mini.surround",
        version = false,
        config = function()
            require("mini.surround").setup({})
        end,
    },
    { "numToStr/Comment.nvim", opts = {} },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        build = ":TSUpdate",
        opts = {
            auto_install = true,
            ignore_install = { "latex" },
            highlight = {
                enable = true,
                disable = { "latex" },
                additional_vim_regex_highlighting = { "latex", "markdown" },
            },
            indent = { enable = true },
            autotag = { enable = true },
            matchup = { enable = true },
        },
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = false, -- use a classic bottom cmdline for search
                command_palette = false, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
        },
    },
    -- {
    --     "windwp/nvim-autopairs",
    --     event = "InsertEnter",
    --     opts = {},
    -- },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        event = "VeryLazy",
        opts = {
            options = {
                disabled_filetypes = {
                    statusline = { "lazy" },
                    winbar = { "help", "lazy", "oil" },
                },
                globalstatus = true,
            },
            winbar = {
                lualine_c = { "filename", "diagnostics" },
            },
            inactive_winbar = {
                lualine_c = { "filename", "diagnostics" },
            },
        },
    },
    {
        "norcalli/nvim-colorizer.lua",
        opts = {
            ["*"] = {
                names = false,
            },
        },
    },
    {
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup()
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
    },
}
