return {
  -- copilotlsp-nvim/copilot-lsp: single Copilot LSP client providing NES.
  -- Requires copilot-language-server binary (auto-installed via mason-tool-installer).
  "copilotlsp-nvim/copilot-lsp",
  dependencies = { "williamboman/mason.nvim" },
  lazy = false,
  init = function()
    vim.g.copilot_nes_debounce = 400
    vim.lsp.enable "copilot_ls"

    -- Suppress noisy "operation was aborted" network errors (harmless, caused by debounce)
    local orig_notify = vim.notify
    vim.notify = function(msg, level, opts)
      if type(msg) == "string" and msg:find("The operation was aborted", 1, true) then return end
      orig_notify(msg, level, opts)
    end

    -- Alt+L (normal mode): walk to NES → accept → request next suggestion
    vim.keymap.set("n", "<M-l>", function()
      local bufnr = vim.api.nvim_get_current_buf()
      if not vim.b[bufnr].nes_state then return end
      local nes = require "copilot-lsp.nes"
      local walked = nes.walk_cursor_start_edit()
      if not walked then
        local applied = nes.apply_pending_nes()
        if applied then
          nes.walk_cursor_end_edit()
          -- Request next NES directly after edit lands
          -- (don't rely on TextChanged debounce which gets reset by cursor movement)
          vim.defer_fn(function()
            local client = vim.lsp.get_clients({ name = "copilot_ls" })[1]
            if client then
              require("copilot-lsp.nes").request_nes(client)
            end
          end, 1000)
        end
      end
    end, { desc = "Copilot NES: walk / accept" })

    -- Esc (normal mode): dismiss NES suggestion
    vim.keymap.set("n", "<Esc>", function()
      require("copilot-lsp.nes").clear()
    end, { desc = "Copilot NES: dismiss" })
  end,
  config = function()
    require("copilot-lsp").setup {
      nes = {
        move_count_threshold = 10,
        distance_threshold = 100,
        clear_on_large_distance = false,
        count_horizontal_moves = false,
        reset_on_approaching = true,
      },
    }
  end,
  specs = {
    -- blink.cmp: Tab navigates menu, Alt+L accepts NES in insert mode
    {
      "Saghen/blink.cmp",
      optional = true,
      opts = {
        keymap = {
          ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
          ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
          ["<M-l>"] = {
            function(cmp)
              local bufnr = vim.api.nvim_get_current_buf()
              if vim.b[bufnr].nes_state then
                cmp.hide()
                local nes = require "copilot-lsp.nes"
                local applied = nes.apply_pending_nes()
                if applied then
                  nes.walk_cursor_end_edit()
                  vim.defer_fn(function()
                    local client = vim.lsp.get_clients({ name = "copilot_ls" })[1]
                    if client then
                      require("copilot-lsp.nes").request_nes(client)
                    end
                  end, 1000)
                end
                return true
              end
            end,
            "fallback",
          },
        },
      },
    },
    -- Auto-install the copilot-language-server binary via Mason
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      optional = true,
      opts = {
        ensure_installed = { "copilot-language-server" },
      },
    },
  },
}
