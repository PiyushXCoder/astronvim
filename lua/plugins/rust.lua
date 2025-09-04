return {
  {
    "AstroNvim/astrolsp",
--    ---@type AstroLSPOpts
    opts = function(plugin, opts)

      local cmd = {
        "systemd-run","--scope","-p", "MemoryMax=6144M", "-p", "MemoryHigh=6144M",
        "--user",
        "rust-analyzer"
        -- "/home/piyush/.cargo/bin/ra-multiplex",
      };


      -- extend our configuration table to have our new prolog server
      opts.config = require("astrocore").extend_tbl(opts.config or {}, {
          rust_analyzer = {
            cmd = cmd
          },
        })

    end,
  }
}
