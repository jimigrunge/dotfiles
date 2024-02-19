return {
  cmd = { "solang", "language-server", "--target", "evm" },
  filetypes = { "solidity" },
  root_dir = require("lspconfig").util.root_pattern(".git/"),
  settings = {
    rootMarkers = { ".git/" },
  }
}
