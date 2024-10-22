return {
  'kosayoda/nvim-lightbulb',
  event = 'LspAttach',
  opts = {
    sign = { enabled = false },
    virtual_text = { enabled = false },
    float = {
      enabled = true,
      hl = 'StatusLine',
    },
    autocmd = { enabled = true },
  },
}
