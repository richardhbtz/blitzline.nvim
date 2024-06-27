local M = {}

function M.setup()
    vim.o.statusline = "%!v:lua.require('" .. "default" .. "')()"
end

function M.update_colors()
end

return M
