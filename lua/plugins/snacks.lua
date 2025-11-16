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
    "folke/snacks.nvim",
    opts = {
        dashboard = {
            preset = {
                header = logo
            },
            sections = {
                { section = "header" },
                { section = "keys", gap = 1, padding = 1 },
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1, gap = 0 },
                { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
                { section = "startup" },
            },

        },
        explorer = {

        }
    }
}
