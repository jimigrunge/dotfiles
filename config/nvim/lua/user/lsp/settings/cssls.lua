return {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_dir = require("lspconfig").util.root_pattern("package.json", ".git"),
  single_file_support = true,
  init_options = {
    provideFormatter = true,
  },
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
