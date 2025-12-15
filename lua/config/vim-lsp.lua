local servers = { "lua_ls", "gopls", "clangd" }
-- Настройка иконок диагностики
local signs = {
    Error = " ",
    Warn = " ",
    Hint = "󱧤 ",
    Info = " ",
}

-- Настройка внешнего вида диагностики
vim.diagnostic.config({
    virtual_text = {
        prefix = "●", -- Префикс для виртуального текста
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
        source = true,             -- Показывать источник диагностики
        header = "",
        prefix = "",
    },
})


-- Настройка Lua Language Server для Neovim
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },             -- Указываем что vim - это глобальная переменная
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

-- Настройка gopls для Go
vim.lsp.config("gopls", {
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
            semanticTokens = true
        },
    },
})

-- Настройка clangd для C/C++
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

-- Автоматический запуск LSP для соответствующих файлов
vim.lsp.enable(servers)
