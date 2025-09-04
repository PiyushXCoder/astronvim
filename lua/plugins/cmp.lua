return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local astrocore, astroui = require "astrocore", require "astroui"
    local function truncate(str, len)
      if not str then return end
      local truncated = vim.fn.strcharpart(str, 0, len)
      return truncated == str and str or truncated .. astroui.get_icon "Ellipsis"
    end

    if not opts.formatting then opts.formatting = {} end
    opts.formatting.format = astrocore.patch_func(opts.formatting.format, function(format, ...)
      -- get item from original formatting function
      local vim_item = format(...)

      -- truncate text fields to maximum of 25% of the window
      vim_item.abbr = truncate(vim_item.abbr, math.floor(0.25 * vim.o.columns))
      vim_item.menu = truncate(vim_item.menu, math.floor(0.25 * vim.o.columns))

      return vim_item
    end)
  end,
}
