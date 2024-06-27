local utils = require "utils"

local function set_highlight(group, fg, bg, bold)
    vim.api.nvim_set_hl(0, group, { fg = fg, bg = bg, bold = bold or false })
end

local default_sep_icons = {
    default = { left = "", right = "" },
    round = { left = "", right = "" },
    block = { left = "█", right = "█" },
    arrow = { left = "", right = "" },
}

local separators = default_sep_icons["default"]

local sep_l = separators["left"]
local sep_r = separators["right"]

local M = {}

M.update_colors = function()
    local new_palette = require("base46").get_colors("base46", require("custom.blitz").theme)
    -- local new_palette = require(vim.g.colors_name .. ".palette")

    local colors = {
        statusline_bg = new_palette.statusline_bg,
        light_grey = new_palette.lightgrey,
        nord_blue = new_palette.nord_blue,
        green = new_palette.green,
        grey = new_palette.grey,
        lightbg = new_palette.lightbg,
        white = new_palette.white,
        red = new_palette.red,
        one_bg = new_palette.one_bg,
        black = new_palette.black,
        yellow = new_palette.yellow,
        dark_purple = new_palette.dark_purple,
        cyan = new_palette.cyan,
        orange = new_palette.orange,
        teal = new_palette.teal,
        blue = new_palette.blue,
    }

    set_highlight("St_gitIcons", colors.light_grey, colors.statusline_bg, true)
    set_highlight("St_Lsp", colors.nord_blue, colors.statusline_bg)
    set_highlight("St_LspMsg", colors.green, colors.statusline_bg)
    set_highlight("St_EmptySpace", colors.grey, colors.lightbg)
    set_highlight("St_file", colors.white, colors.lightbg)
    set_highlight("St_file_sep", colors.lightbg, colors.statusline_bg)
    set_highlight("St_cwd_icon", colors.one_bg, colors.red)
    set_highlight("St_cwd_text", colors.white, colors.lightbg)
    set_highlight("St_cwd_sep", colors.red, colors.statusline_bg)
    set_highlight("St_pos_sep", colors.green, colors.lightbg)
    set_highlight("St_pos_icon", colors.black, colors.green)
    set_highlight("St_pos_text", colors.green, colors.lightbg)
    set_highlight("St_lspError", colors.red, colors.statusline_bg)
    set_highlight("St_lspWarning", colors.yellow, colors.statusline_bg)
    set_highlight("St_LspHints", colors.purple, colors.statusline_bg)
    set_highlight("St_LspInfo", colors.green, colors.statusline_bg)

    local function genModes_hl(modename, col)
        set_highlight("St_" .. modename .. "Mode", colors.black, colors[col], true)
        set_highlight("St_" .. modename .. "ModeSep", colors[col], colors.grey)
    end

    genModes_hl("Normal", "nord_blue")
    genModes_hl("Visual", "cyan")
    genModes_hl("Insert", "dark_purple")
    genModes_hl("Terminal", "green")
    genModes_hl("NTerminal", "yellow")
    genModes_hl("Replace", "orange")
    genModes_hl("Confirm", "teal")
    genModes_hl("Command", "green")
    genModes_hl("Select", "blue")
end

M.mode = function()
    if not utils.is_activewin() then
        return ""
    end

    local modes = utils.modes

    local m = vim.api.nvim_get_mode().mode

    local current_mode = "%#St_" .. modes[m][2] .. "Mode#  " .. modes[m][1] .. " "
    local mode_sep1 = "%#St_" .. modes[m][2] .. "ModeSep#" .. sep_r
    return current_mode .. mode_sep1 .. "%#St_EmptySpace#" .. sep_r
end

M.file = function()
    local x = utils.file()
    local name = " " .. x[2] .. " "
    return "%#St_file# " .. x[1] .. name .. "%#St_file_sep#" .. sep_r
end

M.git = function()
    M.update_colors()
    return "%#St_gitIcons#" .. utils.git()
end

M.lsp_msg = function()
    return "%#St_LspMsg#" .. utils.lsp_msg()
end

M.diagnostics = utils.diagnostics

M.lsp = function()
    return "%#St_Lsp#" .. utils.lsp()
end

M.cwd = function()
    local icon = "%#St_cwd_icon#" .. "󰉋 "
    local name = vim.loop.cwd()
    name = "%#St_cwd_text#" .. " " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
    return (vim.o.columns > 85 and ("%#St_cwd_sep#" .. sep_l .. icon .. name)) or ""
end

M.cursor = "%#St_pos_sep#" .. sep_l .. "%#St_pos_icon# %#St_pos_text# %p %% "
M["%="] = "%="


return function()
    return utils.generate("default", M)
end
