local M = {}

--function M.config()
--end

function M.setup()
    vim.o.statusline = "%!v:lua.require('" .. "default" .. "')()"
end

return M
