return {
  cmd = { "bash-language-server", "start" },
  cmd_env = {
    GLOB_PATTERN = "*@(.sh|.inc|.bash|.command|.local|.zshrc)"
  },
  filetypes = { "sh", "bash", "zsh" },
  root_dir = vim.lsp.util.find_git_ancestor,
  single_file_support = true,
  settings = {
    bashIde = {
      globalPattern = "*@(.sh|.inc|.bash|.command|.local|.zshrc)"
    }
  }
}
