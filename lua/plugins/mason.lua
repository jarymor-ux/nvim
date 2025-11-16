
return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            automatic_enable = true,
            ensure_installed = { "lua_ls", "gopls", "clangd" },
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)

       end,
    },
}
