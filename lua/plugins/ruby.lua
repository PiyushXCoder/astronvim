local function ruby_lsp_installed()
  vim.fn.system({ "bundle", "info", "ruby-lsp" })
  return vim.v.shell_error == 0
end

return {
  {
    "AstroNvim/astrolsp",
    opts = function(plugin, opts)
      local installed = ruby_lsp_installed()

      local fallback = (opts.config.ruby and opts.config.ruby.cmd)
        or { "ruby-lsp" }

      local cmd = installed
        and { "bundle", "exec", "ruby-lsp" }
        or fallback

      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        ruby = {
          -- cmd = cmd
        },
      })
    end,
  },
}




