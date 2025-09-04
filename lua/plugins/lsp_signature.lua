-- Disabling lsp_signature because of following reasons:
-- - It causes annoying popup in nested closures in rust
-- - It random error while using ts_ls
return {
  { "ray-x/lsp_signature.nvim", enabled = false },
}
