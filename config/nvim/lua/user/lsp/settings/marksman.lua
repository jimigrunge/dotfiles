return {
  cmd = { "marksman", "server" },
  filetypes = { "markdown", "markdown.mdx" },
  root_dir = require("lspconfig").util.root_pattern(".git", ".marksman.toml"),
  single_file_support = true
}
