-- Иконки диагностики
local signs = {
    Error = " ",
    Warn = " ",
    Hint = "󱧤 ",
    Info = " ",
}

vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
        spacing = 4,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = signs.Error,
            [vim.diagnostic.severity.WARN] = signs.Warn,
            [vim.diagnostic.severity.HINT] = signs.Hint,
            [vim.diagnostic.severity.INFO] = signs.Info,
        },
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})

-- Глобальные настройки для всех LSP клиентов (новый API в nvim 0.11+)
vim.lsp.config("*", {
    root_markers = { ".git" },
})

-- lua_ls для Neovim. Полные настройки для vim API даёт lazydev.nvim (см. lua/plugins/lazydev.lua)
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            completion = {
                callSnippet = "Replace",
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

vim.lsp.config("gopls", {
    settings = {
        gopls = {
            analyses = {
                ST1000 = false,
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            semanticTokens = true,
        },
    },
})

vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },
    capabilities = {
        offsetEncoding = { "utf-16" },
    },
})

-- В 0.12 рекомендуется явно включать клиенты через vim.lsp.enable.
-- mason-lspconfig также включит их автоматически (automatic_enable = true),
-- но дублирующий enable() безопасен и делает конфиг самодостаточным.
vim.lsp.enable({ "lua_ls", "gopls", "clangd" })
