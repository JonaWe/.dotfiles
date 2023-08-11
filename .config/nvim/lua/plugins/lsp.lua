return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
    'nvim-treesitter/nvim-treesitter-context',
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate"
    },
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
}
