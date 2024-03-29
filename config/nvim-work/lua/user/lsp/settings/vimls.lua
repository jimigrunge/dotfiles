return {
  cmd = { "vim-language-server", "--stdio" },
  filetypes = { "vim" },
  single_file_support = true,
  init_options = {
    diagnostic = {
      enable = true
    },
    indexes = {
      count = 3,
      gap = 100,
      projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
      runtimepath = true
    },
    iskeyword = "@,48-57,_,192-255,-#",
    runtimepath = "",
    suggest = {
      fromRuntimepath = true,
      fromVimruntime = true
    },
    vimruntime = ""
  },
  root_dir = function()
    return vim.fn.getcwd()
    --[[ return vim.lsp.util.find_git_ancestor(fname) or vim.fn.getcwd() ]]
  end
}
