-- Master-ветка nvim-treesitter архивирована и несовместима с nvim 0.12
-- (см. README на https://github.com/nvim-treesitter/nvim-treesitter).
-- Используем main-ветку: это полный rewrite с другим API.
return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")

        ts.setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        local parsers = {
            "c",
            "lua",
            "luadoc",
            "vim",
            "vimdoc",
            "query",
            "markdown",
            "markdown_inline",
            "go",
            "gomod",
            "gosum",
            "bash",
            "json",
            "yaml",
            "toml",
        }

        if vim.fn.executable("tree-sitter") == 1 then
            ts.install(parsers)
        else
            vim.schedule(function()
                vim.notify(
                    "tree-sitter CLI не найден в PATH. Установите его и перезапустите Neovim.",
                    vim.log.levels.WARN
                )
            end)
        end

        -- Включаем подсветку для буферов с установленным парсером.
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local bufnr = args.buf
                local ft = vim.bo[bufnr].filetype
                local lang = vim.treesitter.language.get_lang(ft) or ft
                pcall(vim.treesitter.start, bufnr, lang)
            end,
        })
    end,
}
