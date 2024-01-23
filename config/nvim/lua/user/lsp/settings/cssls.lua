return {
  cmd = { "css-languageserver", "--stdio" },
  filetypes = { "css" },
  root_dir = require("lspconfig").util.root_pattern("package.json", ".git"),
  single_file_support = true,
  settings = {
    css = {
      validate = true
    },
    less = {
      validate = true
    },
    scss = {
      validate = true
    },
    rootMarkers = { "package.json", ".git/" },
  }
}
