return {
  cmd = { "taplo", "lsp", "stdio" },
  filetypes = { "toml" },
  root_dir = require("lspconfig").util.root_pattern("*.toml", ".git"),
  single_file_support = true
}
