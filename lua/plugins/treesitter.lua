-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
-- Customize Treesitter
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function (_, opts)
    vim.filetype.add({
      pattern = {
        [".*grub.cfg"] = "grub",
      },
    })
    vim.treesitter.language.register("bash", "grub")

    opts.ensure_installed = opts.ensure_installed or {}
    opts.ensure_installed = vim.list_extend(opts.ensure_installed, {
      ensure_installed = {
        "lua",
        "vim",
        -- add more arguments for adding more treesitter parsers
      },
    });
  end,
}
