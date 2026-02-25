return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    {
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {
          enabled = true,
        },
        picker = {
          enabled = true,
          actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    local opencode = require("opencode")

    vim.g.opencode_opts = {
      server = {
        start = function()
          require("opencode.terminal").start("opencode --port")
        end,
        stop = function()
          require("opencode.terminal").stop()
        end,
      },
      prompts = {
        ask = { prompt = "", ask = true, submit = true },
        explain = { prompt = "Explain @this and its context", submit = true },
        fix = { prompt = "Fix @diagnostics", submit = true },
        review = { prompt = "Review @this for correctness and readability", submit = true },
        optimize = { prompt = "Optimize @this for performance and readability", submit = true },
        test = { prompt = "Add tests for @this", submit = true },
        document = { prompt = "Add comments documenting @this", submit = true },
        implement = { prompt = "Implement @this", submit = true },
        refactor = { prompt = "Refactor @this for clarity and maintainability", submit = true },
      },
      ask = {
        prompt = "Ask opencode: ",
        completion = "customlist,v:lua.opencode_completion",
        snacks = {
          icon = "󰚩 ",
          win = {
            title_pos = "left",
            relative = "cursor",
            row = -3,
            col = 0,
            footer_keys = { "<CR>", "<S-CR>" },
          },
        },
      },
      select = {
        prompt = "opencode: ",
        snacks = {
          preview = "preview",
          layout = {
            preset = "vscode",
          },
        },
      },
      events = {
        enabled = true,
        reload = true,
        permissions = {
          enabled = true,
          idle_delay_ms = 1000,
        },
      },
      lsp = {
        enabled = true,
      },
    }

    vim.o.autoread = true

    vim.keymap.set({ "n", "x" }, "<C-a>", function() opencode.ask("@this: ", { submit = true }) end, { desc = "Ask opencode about selection" })
    vim.keymap.set({ "n", "x" }, "<C-x>", function() opencode.select() end, { desc = "Open opencode actions" })
    vim.keymap.set({ "n", "t" }, "<C-.>", function() opencode.toggle() end, { desc = "Toggle opencode terminal" })

    vim.keymap.set({ "n", "x" }, "go", function() return opencode.operator("@this ") end, { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n", "goo", function() return opencode.operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function() opencode.command("session.half.page.up") end, { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function() opencode.command("session.half.page.down") end, { desc = "Scroll opencode down" })

    vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
      callback = function()
        pcall(opencode.stop)
        vim.fn.system("pkill -9 -f 'opencode --port' 2>/dev/null")
      end,
    })

    vim.api.nvim_create_autocmd("TermOpen", {
      callback = function(args)
        vim.defer_fn(function()
          local bufname = vim.api.nvim_buf_get_name(args.buf)
          if bufname:find("opencode") then
            vim.bo[args.buf].buflisted = false
          end
        end, 50)
      end,
    })

    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })

    vim.keymap.set({ "n", "v" }, "<leader>ax", function() opencode.prompt("explain") end, { desc = "Explain code" })
    vim.keymap.set({ "n", "v" }, "<leader>af", function() opencode.prompt("fix") end, { desc = "Fix diagnostics" })
    vim.keymap.set({ "n", "v" }, "<leader>ar", function() opencode.prompt("review") end, { desc = "Review code" })
    vim.keymap.set({ "n", "v" }, "<leader>at", function() opencode.prompt("test") end, { desc = "Generate tests" })
  end,
}
