local highlight_range = function(bufnr, ns_id, hl_group, pos1, pos2, opts)
  opts = opts or {}
  local regtype = opts.regtype or 'v'
  local inclusive = opts.inclusive or false
  local priority = opts.priority or 200
  local scoped = opts.scoped or false

  local region = vim.region(bufnr, pos1, pos2, regtype, inclusive)
  for linenr, cols in pairs(region) do
    local end_row = nil
    if cols[2] == -1 then
      end_row = linenr + 1
      cols[2] = 0
    end
    vim.api.nvim_buf_set_extmark(bufnr, ns_id, linenr, cols[1], {
      end_row = end_row,
      end_col = cols[2],
      hl_group = hl_group,
      priority = priority,
      strict = false,
      scoped = scoped,
    })
  end
end

-- highlight yanked text
local yank_hl_group = 'DiffText'
local yank_hl_duration = 200
local yank_hl_timer = nil --- @type uv_timer_t?
local yank_hl_ns_id = vim.api.nvim_create_namespace('YankHighlight')
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'config',
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()

    local highlight_clear = function()
      yank_hl_timer = nil
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_clear_namespace(bufnr, yank_hl_ns_id, 0, -1)
      end
    end

    if yank_hl_timer then
      yank_hl_timer:close()
      highlight_clear()
    end

    highlight_range(bufnr, yank_hl_ns_id, yank_hl_group, "'[", "']", {
      regtype = vim.v.event.regtype,
      inclusive = vim.v.event.inclusive,
    })

    yank_hl_timer = vim.defer_fn(highlight_clear, yank_hl_duration)
  end
})

-- highlight changed text
local change_hl_group = 'DiffAdd'
local change_hl_duration = 200
local change_hl_ns_id = vim.api.nvim_create_namespace('ChangeHighlight')
vim.api.nvim_create_autocmd('BufEnter', {
  group = 'config',
  callback = function()
    if #vim.bo.buftype ~= 0 then
      return
    end

    vim.api.nvim_buf_attach(0, false, {
      on_bytes = function(_, bufnr, _, start_row, start_col, _, _, _, _, new_end_row, new_end_col, _)
        if #vim.bo.buftype ~= 0 then
          return true
        end

        if HighlighterSkip then
          return false
        end

        if vim.api.nvim_get_mode().mode == 'i' then
          return false
        end

        local num_lines = vim.api.nvim_buf_line_count(bufnr)
        local end_row = start_row + new_end_row
        local end_col = start_col + new_end_col

        if end_row >= num_lines then
          end_col = #vim.api.nvim_buf_get_lines(bufnr, -2, -1, false)[1]
        end

        vim.schedule(function()
          highlight_range(
            bufnr,
            change_hl_ns_id,
            change_hl_group,
            { start_row, start_col },
            { end_row, end_col }
          )
        end)

        vim.defer_fn(function()
          if vim.api.nvim_buf_is_valid(bufnr) then
            vim.api.nvim_buf_clear_namespace(bufnr, change_hl_ns_id, 0, -1)
          end
        end, change_hl_duration)
      end,
    })
  end
})
