local logo = [[
 /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\
( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )
 > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <
 /\_/\ ██████╗  ██████╗ ██████╗  █████╗ ██████╗   /\_/\
( o.o )██╔══██╗██╔═══██╗██╔══██╗██╔══██╗╚════██╗ ( o.o )
 > ^ < ██████╔╝██║   ██║██████╔╝███████║  ▄███╔╝  > ^ <
 /\_/\ ██╔═══╝ ██║   ██║██╔═══╝ ██╔══██║  ▀▀══╝   /\_/\
( o.o )██║     ╚██████╔╝██║     ██║  ██║  ██╗    ( o.o )
 > ^ < ╚═╝      ╚═════╝ ╚═╝     ╚═╝  ╚═╝  ╚═╝     > ^ <
 /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\  /\_/\
( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )( o.o )
 > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <  > ^ <
]]

return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
        require("dashboard").setup({
            -- config
            theme = "doom",
            config = {
                header = vim.split(logo, "\n"),
                center = {
                    {
                        action = "ene | startinsert",
                        desc = " New File",
                        icon = " ",
                        key = "n"
                    },
                    {
                        action = "Lazy",
                        desc = " Plugins",
                        icon = " ",
                        key = "p"
                    },
                    {
                        action = "lua require('telescope').extensions.recent_files.pick()",
                        desc = " Recent files",
                        icon = " ",
                        key = "r"
                    },
                    {
                        action = 'e ~/.config/nvim/',
                        desc = " Config",
                        icon = " ",
                        key = "c"
                    },

                },
                footer = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
                end,
                vertical_center = true, -- Center the Dashboard on the vertical (from top to bottom)
            },
        })
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
