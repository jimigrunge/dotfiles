return {
  cmd = { "bash-language-server", "start" },
  cmd_env = {
    GLOB_PATTERN = "*@(.sh|.inc|.bash|.command|.local)"
  },
  filetypes = { "sh" },
  root_dir = vim.lsp.util.find_git_ancestor,
  single_file_support = true,
  settings =   {
    bashIde = {
      globalPattern = "*@(.sh|.inc|.bash|.command|.local)"
    }
  }
}
