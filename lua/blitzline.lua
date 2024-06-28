local M = {}

function M.setup()
	vim.o.statusline = "%!v:lua.require('default')()"
end

return M
