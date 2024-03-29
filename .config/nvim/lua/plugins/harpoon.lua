return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup({})
    end,
    keys = {
        {
            "<leader>a",
            function()
                require("harpoon"):list():append()
            end,
            "Harpoon Append File",
        },
        {
            "<C-e>",
            function()
                require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
            end,
            "Harpoon Show List",
        },
        {
            "<C-h>",
            function()
                require("harpoon"):list():select(1)
            end,
            "Harpoon Select 1",
        },
        {
            "<C-j>",
            function()
                require("harpoon"):list():select(2)
            end,
            "Harpoon Select 2",
        },
        {
            "<C-k>",
            function()
                require("harpoon"):list():select(3)
            end,
            "Harpoon Select 3",
        },
        {
            "<C-l>",
            function()
                require("harpoon"):list():select(4)
            end,
            "Harpoon Select 4",
        },
    },
}
