if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",

        -- install formatters
        "stylua",

        -- install debuggers
        "debugpy",

        -- install any other package
        "tree-sitter-cli",

        -- I use them personally
        "asm-lsp",
        "bash-language-server",
        "clangd",
        "codelldb",
        "copilot-language-server",
        "css-lsp",
        "dockerfile-language-server",
        "eslint-lsp",
        "gopls",
        "htmx-lsp",
        "java-debug-adapter",
        "java-test",
        "jdtls",
        "json-lsp",
        "lemminx",
        "lua-language-server",
        "luaformatter",
        "markdown-oxide",
        "phpactor",
        "prettier",
        "prisma-language-server",
        "pyright",
        "rust-analyzer",
        "sqls",
        "svelte-language-server",
        "tailwindcss-language-server",
        "taplo",
        "typescript-language-server",
        "yaml-language-server"
      },
    },
  },
}
