return {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_dir = require("lspconfig").util.root_pattern("composer.json", ".git"),
  single_file_support = true,
  settings = {
    rootMarkers = { ".git/", "composer.json" },
  }
}
