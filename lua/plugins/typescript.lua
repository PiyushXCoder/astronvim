-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  opts = {
    -- enable servers that you already have installed without mason
    servers = {
      "tsserver",
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      tsserver = {
        cmd = {
          "typescript-language-server",
          "--stdio",
          "--tsserver-max-memory=1024",
        },
      },
    },
  },
}
