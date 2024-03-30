local status_ok, schemastore = pcall(require, "schemastore")
if not status_ok then
  return {}
end

return {
  settings = {
    json = {
      schemas = schemastore.json.schemas(),
      validate = { enable = true },
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  },
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_dir = require("lspconfig").util.root_pattern(".git"),
  single_file_support = true,
  init_options = {
    provideFormatter = true
  }
}
