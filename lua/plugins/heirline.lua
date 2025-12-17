return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astroui.status")
    opts.statusline = { -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      status.component.git_branch(),
      status.component.builder({
        provider = function()
          local buf = vim.api.nvim_get_current_buf()
          local bufname = vim.api.nvim_buf_get_name(buf)
          if bufname == "" then
            return ""
          end

          local filetype = vim.bo[buf].filetype

          -- filetype icon
          local devicons = require("nvim-web-devicons")
          local icon = devicons.get_icon_by_filetype(filetype, { default = true }) or ""

          -- readonly lock
          local lock = vim.bo[buf].readonly and "" or ""

          -- relative path
          local path = vim.fn.expand("%:.")

          -- 🔑 explicit spacing between elements
          local parts = {}
          if icon ~= "" then table.insert(parts, icon) end
          if lock ~= "" then table.insert(parts, lock) end
          table.insert(parts, path)

          return table.concat(parts, " ") -- one space separator
        end,

        hl = function()
          local bufname = vim.api.nvim_buf_get_name(0)
          local filename = vim.fn.fnamemodify(bufname, ":t")
          local _, hl = require("nvim-web-devicons")
            .get_icon(filename, nil, { default = true })
          return hl
        end,

      }),
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.virtual_env(),
      status.component.treesitter(),
      status.component.nav(),
      -- remove the 2nd mode indicator on the right
    }
  end,
}
