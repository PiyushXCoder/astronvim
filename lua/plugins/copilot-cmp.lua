return {
  -- blink-copilot: native blink.cmp source for Copilot, works directly with copilot-lsp.
  -- Replaces copilot-cmp + blink.compat — no second LSP client needed.
  {
    "fang2hou/blink-copilot",
    lazy = false,
    specs = {
      {
        "Saghen/blink.cmp",
        optional = true,
        dependencies = { "fang2hou/blink-copilot" },
        opts = {
          sources = {
            default = { "copilot", "lsp", "path", "snippets", "buffer" },
            providers = {
              copilot = {
                name = "copilot",
                module = "blink-copilot",
                score_offset = 100,
                async = true,
                opts = {
                  max_completions = 3, -- show up to 3 Copilot suggestions
                },
              },
            },
          },
        },
      },
    },
  },
  -- Disable copilot-cmp and blink.compat — no longer needed
  { "zbirenbaum/copilot-cmp", enabled = false },
  { "Saghen/blink.compat", enabled = false },
}
