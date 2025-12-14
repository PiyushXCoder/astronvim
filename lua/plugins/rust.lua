return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allTargets = true,
              },
            },
          },
        },
      })
    end,
  },
}


-- The belowe is an alternative standalone configuration for rust-analyzer. You can
-- learn how differtent LSPs are configured in AstroNvim:
--
-- AstroNvim Configuration:
--
-- return {
--   {
--     "AstroNvim/astrolsp",
--     opts = function(_, opts)
--       opts.config = require("astrocore").extend_tbl(opts.config or {}, {
--         rust_analyzer = {
--           settings = {
--             ["rust-analyzer"] = {
--               cargo = {
--                 allTargets = true,
--               },
--             },
--           },
--         },
--       })
--     end,
--   },
-- }
--
-- Standalone Configuration:
--
-- require("lspconfig").rust_analyzer.setup({
--   settings = {
--     ["rust-analyzer"] = {
--       cargo = {
--         allTargets = true,
--       },
--     },
--   },
-- })
