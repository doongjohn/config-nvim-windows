_G.Config = {}

_G.Config.buf_get_short_path = function()
	local filepath = vim.fs.normalize(vim.fn.expand("%:.:h"))
	if not filepath or filepath == "." then
		return ""
	end
	local parts = vim.split(filepath, "/")
	local n = #parts
	if n >= 3 then
		return "…/" .. table.concat(vim.list_slice(parts, math.max(n - 2, 1)), "/")
	else
		return filepath
	end
end

_G.Config.oil_get_path = function()
	return vim.api.nvim_buf_get_name(0):sub(7, -1)
end
