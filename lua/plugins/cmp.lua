return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Источники автодополнения
      "hrsh7th/cmp-nvim-lsp", -- LSP источник
      "hrsh7th/cmp-buffer",   -- Буферы
      "hrsh7th/cmp-path",     -- Пути файловой системы
      "hrsh7th/cmp-cmdline",  -- Командная строка
      "hrsh7th/cmp-nvim-lua", -- Neovim Lua API

      -- Сниппеты
      "L3MON4D3/LuaSnip",             -- Движок сниппетов
      "saadparwaiz1/cmp_luasnip",     -- Интеграция LuaSnip с cmp
      "rafamadriz/friendly-snippets", -- Коллекция сниппетов

      -- Иконки
      "onsails/lspkind.nvim", -- Красивые иконки в меню автодополнения
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      -- Загрузка сниппетов из friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Настройка LuaSnip
      luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })

      -- Функция для проверки наличия слова перед курсором
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        -- Настройка сниппетов
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- Маппинги клавиш
        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Ctrl+u - прокрутка вверх
          ["<C-d>"] = cmp.mapping.scroll_docs(4),  -- Ctrl+d - прокрутка вниз
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          -- Tab для навигации и расширения сниппетов
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        -- Источники автодополнения (в порядке приоритета)
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },                  -- LSP (для Go, Lua и других)
          { name = "luasnip",  priority = 750 },                   -- Сниппеты
          { name = "nvim_lua", priority = 700 },                   -- Neovim Lua API
          { name = "path",     priority = 500 },                   -- Пути файлов
          { name = "buffer",   priority = 250, keyword_length = 3 }, -- Буфер
        }),

        -- Форматирование меню автодополнения
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",  -- Показывать иконку и текст
            maxwidth = 50,         -- Максимальная ширина меню
            ellipsis_char = "...", -- Символ обрезания

            -- Кастомные иконки для разных источников
            menu = {
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              nvim_lua = "[Lua]",
              buffer = "[Buf]",
              path = "[Path]",
            },

            before = function(entry, vim_item)
              return vim_item
            end,
          }),
        },

        -- Внешний вид окна
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
          }),
        },

        -- Экспериментальные фичи
        experimental = {
          ghost_text = true, -- Показывать предварительный текст
        },
      })

      -- Автодополнение для командной строки (/)
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Автодополнение для командной строки (:)
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- Специфичные настройки для разных типов файлов

      -- Для Go файлов
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          cmp.setup.buffer({
            sources = {
              { name = "nvim_lsp", priority = 1000 },
              { name = "luasnip",  priority = 750 },
              { name = "path",     priority = 500 },
              { name = "buffer",   priority = 250, keyword_length = 4 },
            },
          })
        end,
      })

      -- Для Lua файлов
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lua",
        callback = function()
          cmp.setup.buffer({
            sources = {
              { name = "nvim_lua", priority = 1000 },
              { name = "nvim_lsp", priority = 900 },
              { name = "luasnip",  priority = 750 },
              { name = "path",     priority = 500 },
              { name = "buffer",   priority = 250, keyword_length = 3 },
            },
          })
        end,
      })

      -- Для C/C++ файлов
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp", "cc", "h", "hpp" },
        callback = function()
          cmp.setup.buffer({
            sources = {
              { name = "nvim_lsp", priority = 1000 }, -- clangd LSP
              { name = "luasnip",  priority = 750 },
              { name = "path",     priority = 500 },
              { name = "buffer",   priority = 250, keyword_length = 4 },
            },
          })
        end,
      })
    end,
  },
}
