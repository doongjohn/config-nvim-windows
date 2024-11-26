local function highlight_range(bufnr, ns_id, hl_group, pos1, pos2)
	local region = vim.fn.getregionpos(pos1, pos2)
	for _, segment in ipairs(region) do
		local start_pos, end_pos = unpack(segment)
		vim.api.nvim_buf_set_extmark(bufnr, ns_id, start_pos[2] - 1, start_pos[3] - 1, {
			hl_group = hl_group,
			end_col = end_pos[3],
			priority = 199,
			strict = false,
		})
	end
end

-- highlight yanked text
local yank_hl_group = "DiffText"
local yank_hl_duration = 200
local yank_hl_timer = nil --- @type uv.uv_timer_t?
local yank_hl_ns_id = vim.api.nvim_create_namespace("YankHighlight")

vim.api.nvim_create_autocmd("TextYankPost", {
	group = "config",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()

		local function highlight_clear()
			yank_hl_timer = nil
			if vim.api.nvim_buf_is_valid(bufnr) then
				vim.api.nvim_buf_clear_namespace(bufnr, yank_hl_ns_id, 0, -1)
			end
		end

		if yank_hl_timer then
			yank_hl_timer:close()
			highlight_clear()
		end

		local pos1 = vim.fn.getpos("'[")
		local pos2 = vim.fn.getpos("']")
		highlight_range(bufnr, yank_hl_ns_id, yank_hl_group, pos1, pos2)
		yank_hl_timer = vim.defer_fn(highlight_clear, yank_hl_duration)
	end,
})
