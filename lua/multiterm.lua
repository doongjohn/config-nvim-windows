local M = {}

local term_opts = {
	shell = "nu",
	term_hl = "Normal",
	height = 0.8,
	width = 0.8,
	height_value = function(self)
		return math.floor(vim.o.lines * self.height)
	end,
	width_value = function(self)
		return math.floor(vim.o.columns * self.width)
	end,
	row = function(self)
		local h = self.height_value(self)
		return math.floor((vim.o.lines - h) / 2) - 1
	end,
	col = function(self)
		local w = self.width_value(self)
		return math.floor((vim.o.columns - w) / 2)
	end,
	on_term_show = function(buf)
		vim.keymap.set({ "n", "t" }, "<c-k>", M.hide_term, { buffer = buf })
		vim.keymap.set({ "n", "t" }, "<c-]>", M.next_term, { buffer = buf })
		vim.keymap.set({ "n", "t" }, "<c-[>", M.prev_term, { buffer = buf })
	end,
}

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = "config",
	callback = function()
		local is_multiterm = pcall(vim.api.nvim_buf_get_var, 0, "multiterm_tag")
		local is_floating_win = vim.api.nvim_win_get_config(0).relative ~= ""
		local is_normal_buf = #vim.bo.buftype == 0
		if is_multiterm == true or (is_normal_buf and not is_floating_win) then
			vim.keymap.set("n", "<c-k>", function()
				M.toggle_term(M.get_input_term_tag())
			end, { buffer = true })
		end
	end,
})

local backdrop_buf = nil
local backdrop_win = nil
local bgfill_buf = nil
local bgfill_win = nil

local term_bufs = {}
local term_wins = {}
local cur_term_tag = nil
local last_term_tag = 1

vim.api.nvim_set_hl(0, "MultitermBackdrop", { bg = "Black" })

vim.api.nvim_create_augroup("multiterm", {})

vim.api.nvim_create_autocmd("WinLeave", {
	group = "multiterm",
	callback = function()
		local ok, tag = pcall(vim.api.nvim_win_get_var, 0, "multiterm_tag")
		if ok then
			if term_wins[tag] then
				pcall(vim.api.nvim_win_close, term_wins[tag], true)
				term_wins[tag] = nil
			end
			if cur_term_tag == tag then
				cur_term_tag = nil
				M.hide_bg()
			end
		end
	end,
})

M.get_last_term_tag = function()
	return last_term_tag
end

M.get_input_term_tag = function()
	return vim.v.count ~= 0 and vim.v.count or M.get_last_term_tag()
end

M.show_bg = function()
	if backdrop_buf then
		return
	end

	-- backdrop
	do
		local backdrop_opts = {
			relative = "editor",
			row = 0,
			col = 0,
			width = vim.o.columns,
			height = vim.o.lines,
			style = "minimal",
			focusable = false,
			zindex = 10, -- default float zindex is 50
		}

		backdrop_buf = vim.api.nvim_create_buf(false, true)
		backdrop_win = vim.api.nvim_open_win(backdrop_buf, false, backdrop_opts)

		local opts_buf = { scope = "local", buf = backdrop_buf }
		local opts_win = { scope = "local", win = backdrop_win }

		vim.api.nvim_set_option_value("winhighlight", "NormalFloat:MultitermBackdrop", opts_win)
		vim.api.nvim_set_option_value("winblend", 60, opts_win)
		vim.api.nvim_set_option_value("bufhidden", "wipe", opts_buf)
	end

	-- bgfill
	do
		local opts = term_opts
		local height = opts.height_value(opts)
		local width = opts.width_value(opts)
		local row = opts.row(opts)
		local col = opts.col(opts)

		local bgfill_opts = {
			relative = "editor",
			row = row,
			col = col,
			width = width,
			height = height,
			style = "minimal",
			border = { " ", " ", " ", " ", "", "", "", " " },
			focusable = false,
			zindex = 11,
		}

		bgfill_buf = vim.api.nvim_create_buf(false, true)
		bgfill_win = vim.api.nvim_open_win(bgfill_buf, false, bgfill_opts)

		local opts_buf = { scope = "local", buf = bgfill_buf }
		local opts_win = { scope = "local", win = bgfill_win }

		local hl = "NormalFloat:" .. opts.term_hl .. ",FloatBorder:" .. opts.term_hl
		vim.api.nvim_set_option_value("winhighlight", hl, opts_win)
		vim.api.nvim_set_option_value("bufhidden", "wipe", opts_buf)
	end
end

M.hide_bg = function()
	pcall(vim.api.nvim_buf_delete, backdrop_buf, { force = true })
	pcall(vim.api.nvim_win_close, backdrop_win, true)
	backdrop_buf = nil
	backdrop_win = nil

	pcall(vim.api.nvim_buf_delete, bgfill_buf, { force = true })
	pcall(vim.api.nvim_win_close, bgfill_win, true)
	bgfill_buf = nil
	bgfill_win = nil
end

M.show_term = function(tag, cmd)
	if tag == nil or type(tag) ~= "number" then
		vim.notify("tag must be a number", vim.log.levels.ERROR)
		return
	end

	if cur_term_tag == tag then
		return
	end
	cur_term_tag = tag
	last_term_tag = tag

	local opts = term_opts
	local height = opts.height_value(opts)
	local width = opts.width_value(opts)
	local row = opts.row(opts)
	local col = opts.col(opts)

	cmd = cmd or ""
	cmd = cmd ~= "" and cmd or opts.shell

	local start_term = false
	if not term_bufs[tag] or not vim.api.nvim_buf_is_valid(term_bufs[tag]) then
		term_bufs[tag] = vim.api.nvim_create_buf(false, false)
		vim.api.nvim_buf_set_var(term_bufs[tag], "multiterm_tag", tag)
		start_term = true
	end

	local win_opts = {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		border = { "", "", "", " ", "", "", "", " " },
	}

	term_wins[tag] = vim.api.nvim_open_win(term_bufs[tag], true, win_opts)
	vim.api.nvim_win_set_var(term_wins[tag], "multiterm_tag", tag)

	local opts_win = { scope = "local", win = term_wins[tag] }

	local hl = "NormalFloat:" .. opts.term_hl .. ",FloatBorder:" .. opts.term_hl
	vim.api.nvim_set_option_value("winhighlight", hl, opts_win)
	vim.api.nvim_set_option_value("winbar", "%#TabLineSel# terminal " .. tag .. " %#Normal#", opts_win)

	if start_term then
		vim.fn.jobstart(cmd, {
			term = true,
			on_exit = function()
				if term_bufs[tag] and vim.api.nvim_buf_is_valid(term_bufs[tag]) then
					if not M.next_term() and not M.prev_term() then
						M.hide_bg()
						last_term_tag = 1
					end

					local close_buf = term_bufs[tag]
					vim.defer_fn(function()
						vim.api.nvim_buf_delete(close_buf, { force = true })
					end, 10)
					term_bufs[tag] = nil

					pcall(vim.api.nvim_win_close, term_wins[tag], true)
					term_wins[tag] = nil
				end
			end,
		})
	end

	vim.cmd("startinsert")
	opts.on_term_show(term_bufs[tag])
end

M.hide_term = function(tag)
	tag = tag or cur_term_tag
	if term_wins[tag] then
		pcall(vim.api.nvim_win_close, term_wins[tag], true)
	end
end

M.toggle_term = function(tag)
	if cur_term_tag then
		M.hide_bg()
		M.hide_term()
	else
		M.show_bg()
		M.show_term(tag)
	end
end

local sorted_tags = function()
	local t = vim.tbl_keys(term_bufs)
	table.sort(t)
	return t
end

M.next_term = function(ref_tag)
	ref_tag = ref_tag or cur_term_tag
	if ref_tag then
		local next = nil
		local prev = nil
		for tag in pairs(sorted_tags()) do
			if prev == ref_tag and tag ~= nil then
				next = tag
				break
			end
			prev = tag
		end
		if next then
			M.show_term(next)
			M.hide_term(ref_tag)
			return true
		end
	end
	return false
end

M.prev_term = function(ref_tag)
	ref_tag = ref_tag or cur_term_tag
	if ref_tag then
		local next = nil
		for tag in pairs(sorted_tags()) do
			if tag == ref_tag then
				break
			end
			if tag ~= nil then
				next = tag
			end
		end
		if next then
			M.show_term(next)
			M.hide_term(ref_tag)
			return true
		end
	end
	return false
end
