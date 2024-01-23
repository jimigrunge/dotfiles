return {
  cmd = { "stimulus-language-server", "--stdio" },
  filetypes = { "html", "ruby", "eruby", "blade", "php" },
  root_dir = require("lspconfig").util.root_pattern("composer.json", ".git"),
  single_file_support = true,
}

