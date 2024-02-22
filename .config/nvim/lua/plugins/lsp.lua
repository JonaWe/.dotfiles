local function setup_lsp_diagnostic()
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.diagnostic.config({
        signs = {
            active = signs,
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })
end

return {
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        keys = {
            {
                "<leader>tt",
                function()
                    require("trouble").toggle()
                end,
                "",
            },
            {
                "<leader>tw",
                function()
                    require("trouble").toggle("workspace_diagnostics")
                end,
                "",
            },
            {
                "<leader>td",
                function()
                    require("trouble").toggle("document_diagnostics")
                end,
                "",
            },
        },
    },
    {
        "j-hui/fidget.nvim",
        lazy = false,
        opts = {
            progress = {
                suppress_on_insert = true,
                ignore = { "ltex" },
                display = {
                    overrides = {
                        ltex = { name = "LTex" },
                    },
                },
            },
        },
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
        ft = { "rust" },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "folke/neodev.nvim", config = true },
            { "williamboman/mason.nvim", config = true },
            "j-hui/fidget.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright",
                    "clangd",
                    "volar",
                    "lua_ls",
                    "rust_analyzer",
                    "jdtls",
                    "tsserver",
                    "tailwindcss",
                    "eslint",
                    "kotlin_language_server",
                    "omnisharp",
                    "omnisharp",
                    "ltex",
                    "texlab",
                },
                handlers = {
                    function(server_name)
                        if server_name ~= "rust_analyzer" then
                            require("lspconfig")[server_name].setup({})
                        end
                    end,
                    ["ltex"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.ltex.setup({
                            filetypes = { "tex" },
                            settings = {
                                ltex = {
                                    language = "en-US",
                                },
                            },
                        })
                    end,
                },
            })

            setup_lsp_diagnostic()

            vim.keymap.set("n", "<space>cd", vim.diagnostic.open_float, { desc = "Open Diagnostic" })
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                tex = { "latexindent" },
            },
            formatters = {
                latexindent = {
                    prepend_args = { "-l" },
                },
            },
        },
    },
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                markdown = { "markdownlint" },
                python = { "pylint" },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
    {
        "aznhe21/actions-preview.nvim",
        opts = {
            telescope = {
                sorting_strategy = "ascending",
                layout_strategy = "vertical",
                layout_config = {
                    width = 0.8,
                    height = 0.9,
                    prompt_position = "top",
                    preview_cutoff = 20,
                    preview_height = function(_, _, max_lines)
                        return max_lines - 15
                    end,
                },
            },
        },
    },
}
