return {
  cmd = {
    -- os.getenv('HOME') .. "/bin/lemminx"
    "lemminx"
  },
  filetypes = { "xml", "xsd", "svg", "xsl", "xslt" },
  root_dir = vim.lsp.util.find_git_ancestor,
  single_file_support = true,
  settings = {
    xml = {
      fileAssociations = {
        {
          systemId = os.getenv('HOME') .. "/path/to/definition.xsd",
          pattern = "**/.xml"
        }
      }
    }
  }
}
