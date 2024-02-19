local status_ok, schemastore = pcall(require, "schemastore")
if not status_ok then
  return {}
end

return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose" },
  root_dir = vim.lsp.util.find_git_ancestor,
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = schemastore.yaml.schemas(),
    },
    redhat = {
      telemetry = {
        enabled = false
      }
    },
  },
  single_file_support = true
}
