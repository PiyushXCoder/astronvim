return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    if os.getenv("NOCOPILOT") then
      vim.notify("Copilot is disabled by environment variable NOCOPILOT", vim.log.levels.WARN)
      return
    end

    local copilot = require("copilot")
    copilot.setup({
      enabled = true,
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<cr>",
          refresh = "gr",
          open = "<m-cr>"
        },
        layout = {
          position = "bottom", -- | top | left | right | horizontal | vertical
          ratio = 0.4
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        trigger_on_accept = true,
        keymap = {
          accept = "<m-l>",
          accept_word = false,
          accept_line = false,
          next = "<m-]>",
          prev = "<m-[>",
          dismiss = "<c-]>",
        },
      },
      filetypes = {
        gpg = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      auth_provider_url = nil, -- url to authentication provider, if not "https://github.com/"
      logger = {
        file = vim.fn.stdpath("log") .. "/copilot-lua.log",
        file_log_level = vim.log.levels.OFF,
        print_log_level = vim.log.levels.WARN,
        trace_lsp = "off", -- "off" | "messages" | "verbose"
        trace_lsp_progress = false,
        log_lsp_messages = false,
      },
      copilot_node_command = 'node', -- node.js version must be > 20
      workspace_folders = {},
      -- copilot_model = "claude-sonnet-45",  -- current lsp default is gpt-35-turbo, supports gpt-4o-copilot
      root_dir = function()
        return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
      end,
      should_attach = function(bufnr, _)
        if not vim.bo.buflisted then
          -- vim.notify("not attaching, buffer is not 'buflisted'", vim.log.levels.DEBUG)
          return false
        end

        if vim.bo.buftype ~= "" then
          vim.notify("not attaching, buffer 'buftype' is " .. vim.log.levels.DEBUG)
          return false
        end

        local name = vim.api.nvim_buf_get_name(bufnr)
        if name:match("%.gpg$") then
          return false
        end

        return true
      end,
      server = {
        type = "binary", -- "nodejs" | "binary"
        custom_server_filepath = nil,
      },
      server_opts_overrides = {},
    })
  end,
}
