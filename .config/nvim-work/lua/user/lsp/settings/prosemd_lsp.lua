return {
  cmd = { "prosemd-lsp", "--stdio" },
  filetypes = { "markdown" },
  root_dir = require("lspconfig").util.root_pattern(".git"),
  single_file_support = true
}
