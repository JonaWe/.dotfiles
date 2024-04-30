return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
            require("luasnip").config.set_config({
                -- Enable autotriggered snippets
                enable_autosnippets = true,

                -- Use Tab (or some other key if you prefer) to trigger visual selection
                store_selection_keys = "<Tab>",
                -- history = true,
                updateevents = "TextChanged,TextChangedI",
            })
            local ls = require("luasnip")

            vim.keymap.set({ "i" }, "<C-k>", function()
                ls.expand()
            end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-l>", function()
                ls.jump(1)
            end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-h>", function()
                ls.jump(-1)
            end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<C-e>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true })
            require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            -- "Saecki/crates.nvim",
            -- {
            --     dir = "~/projects/cmp-i18n/",
            -- },
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-i>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lua" },
                    { name = "nvim_lsp" },
                    { name = "copilot" },
                    { name = "path" },
                    { name = "obsidian" },
                    { name = "emoji" },
                    { name = "luasnip" },
                    { name = "buffer", keyword_length = 3 },
                }),
            })
        end,
    },
}
