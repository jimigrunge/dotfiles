return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose" },
  root_dir = vim.lsp.util.find_git_ancestor,
  settings = {
    -- yaml = {
    --   schemas = {
    --     -- Examples
    --     -- ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
    --     -- ["../path/relative/to/file.yml"] = "/.github/workflows/*",
    --     -- ["/path/from/root/of/project"] = "/.github/workflows/*",
    --   },
    -- },
    redhat = {
      telemetry = {
        enabled = false
      }
    },
  },
  single_file_support = true
}
