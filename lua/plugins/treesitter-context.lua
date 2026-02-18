return {
  "nvim-treesitter/nvim-treesitter-context",
  opts = {
    enable = true,
    multiwindow = false,
    max_lines = 0,
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 3,
    trim_scope = 'outer',
    mode = 'cursor',
    separator = nil,
    zindex = 20,
    on_attach = nil,
  },
  config = function(_, opts)
    require("treesitter-context").setup(opts)
    vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = false })
    vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#2a2a3a" })
    vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = "#2a2a3a" })
  end,
}
