-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing
--

function copy_with_path_and_lines()
  local path = vim.fn.expand("%")
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")

  if vim.fn.mode() == "n" then
    start_line = vim.fn.line(".")
    end_line = start_line
  end

  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local lines = vim.fn.getline(start_line, end_line)
  local content

  if start_line == end_line then
    content = string.format("%s:%d: %s", path, start_line, lines[1])
  else
    content = string.format(
      "%s:%d-%d:\n%s",
      path,
      start_line,
      end_line,
      table.concat(lines, "\n")
    )
  end

  vim.fn.setreg("+", content)
  -- vim.notify("Copied with path + line info 🚀")
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        shell = "/bin/fish",
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        exrc = true, -- sets vim.opt.exrc
        secure = true, -- sets vim.opt.secure
        -- mouse = "c"
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<C-S-j>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<C-S-k>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- run program 
        ["<f10>"] = {
          function()
            vim.cmd("!fish run.fish")
          end,
          desc = "Run program",
        },

        ["0"] = {"^", desc = "goto start of the text"},
        ["00"] = {"0", desc = "goto start of the line"},
        ["^"] = {"0", desc = "goto start of the line"},

        ["<C-`>"] = { ":ToggleTerm<CR>", desc = "Toggle terminal" },

        ["<Leader>fS"] = {":Telescope git_status<CR>", desc = "Git status"},

        ["<C-S-y>"] = {
          copy_with_path_and_lines,
          desc = "Copy line with relative path",
        },

        ["0"] = {"^", desc = "goto start of the text"},
        ["^"] = {"0", desc = "goto start of the line"},
      },
      v = {
        ["<C-S-y>"] = {
          copy_with_path_and_lines,
          desc = "Copy selection with relative path",
        },

        ["0"] = {"^", desc = "goto start of the text"},
        ["^"] = {"0", desc = "goto start of the line"},
      },
      t = {
        -- setting a mapping to false will disable it
        ["<Esc><Esc>"] = { "<C-\\><C-n>", desc = "Exit terminal mode" }
      }
    },
  },
}
