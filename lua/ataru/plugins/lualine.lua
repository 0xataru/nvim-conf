return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "vscode",
                -- theme = "onedark",
                icons_enabled = true,
                component_separators = "|",
                section_separators = "",
                globalstatus = true,
                disabled_filetypes = {
                    statusline = { "neo-tree", "dashboard", "alpha" },
                },
            },

            sections = {
                lualine_a = {
                    {
                        "mode",
                        fmt = function(str)
                            return str:sub(1, 1)
                        end,
                    },
                },
                lualine_b = {
                    { "branch", icon = "" },
                },
                lualine_c = {
                    {
                        "filename",
                        path = 1, -- relative path
                        symbols = {
                            modified = "●",
                            readonly = "",
                            unnamed = "",
                        },
                    },
                },
                lualine_x = {
                    "diagnostics",
                },
                lualine_y = {
                    "filetype",
                },
                lualine_z = {
                    "location",
                },
            },

            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
        })
    end,
}
