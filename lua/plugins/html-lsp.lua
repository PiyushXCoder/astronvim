return {
  {
    "AstroNvim/astrolsp",
    opts = function(plugin, opts)
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        html = { -- ✅ this MUST be `html`, not `html_lsp`
          filetypes = { "html", "templ", "eruby", "erb" },
        },
      })
    end,
  },
}
