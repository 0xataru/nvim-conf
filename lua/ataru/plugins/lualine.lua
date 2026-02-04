return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- Get foreground color of a highlight group (no external deps like Snacks)
        local function hl_fg(name)
            local hl = vim.api.nvim_get_hl(0, { name = name })
            if hl and hl.fg then
                return string.format("#%06x", hl.fg)
            end
            return nil
        end

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
                    "diff",
                    {
                        function()
                            return require("noice").api.status.command.get()
                        end,
                        cond = function()
                            return package.loaded["noice"] and require("noice").api.status.command.has()
                        end,
                        color = function()
                            local fg = hl_fg("Statement")
                            return fg and { fg = fg } or {}
                        end,
                    },
                    {
                        function()
                            return require("noice").api.status.mode.get()
                        end,
                        cond = function()
                            return package.loaded["noice"] and require("noice").api.status.mode.has()
                        end,
                        color = function()
                            local fg = hl_fg("Constant")
                            return fg and { fg = fg } or {}
                        end,
                    },
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = function()
                            local fg = hl_fg("Special")
                            return fg and { fg = fg } or {}
                        end,
                    },
                },
                lualine_y = {
                    "filetype",
                },
                lualine_z = {
                    -- { "progress", separator = " ", padding = { left = 1, right = 0 } },
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
