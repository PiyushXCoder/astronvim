return {
  {
    "AstroNvim/astrolsp",
--    ---@type AstroLSPOpts
    opts = function(plugin, opts)
      local f = io.open('.nvim_lspconfig.lua')
      local query_driver= nil
      if f ~= nil then
        io.close(f)
        local conf = dofile('.nvim_lspconfig.lua')
        query_driver = "--query-driver=" .. conf.query_driver
      end
      -- vim.notify("=> " .. query_driver, "info")

      local cmd = {
        "clangd",
        "--log=error",
        "--enable-config",
        "--clang-tidy",
        "--all-scopes-completion=false",
        "--background-index",
        "--header-insertion=never",
        "--pch-storage=memory",
      };

      if query_driver ~= nil then
        table.insert(cmd, query_driver)
      end


      -- extend our configuration table to have our new prolog server
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
          clangd = {
            capabilities = {
              offsetEncoding = "utf-8",
            },
            cmd = cmd
          },
        })

    end,
  },
  {
    "p00f/clangd_extensions.nvim", -- install lsp plugin
    lazy = true,
    init = function()
      -- load clangd extensions when clangd attaches
      local augroup =
      vim.api.nvim_create_augroup("clangd_extensions", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = augroup,
        desc = "Load clangd_extensions with clangd",
        callback = function(args)
          if
            assert(vim.lsp.get_client_by_id(args.data.client_id)).name
            == "clangd"
          then
            require("clangd_extensions")
              -- add more `clangd` setup here as needed such as loading autocmds
              vim.api.nvim_del_augroup_by_id(augroup) -- delete auto command since it only needs to happen once
            end
          end,
        })
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "clangd" }, -- automatically install lsp
      },
    },
  }
