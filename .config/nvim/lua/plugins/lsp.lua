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
        "neovim/nvim-lspconfig",
        dependencies = {
            { "folke/neodev.nvim", config = true },
            { "j-hui/fidget.nvim", config = true },
            { "williamboman/mason.nvim", config = true },
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
                },
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,
                },
            })

            setup_lsp_diagnostic()

            vim.keymap.set("n", "<space>cd", vim.diagnostic.open_float)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
            },
            -- format_on_save = {
            --     timeout_ms = 500,
            --     lsp_fallback = true,
            -- }
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
