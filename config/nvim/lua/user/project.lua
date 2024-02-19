local M = {
  "ahmedkhalf/project.nvim",
  commit = "8c6bad7d22eef1b71144b401c9f74ed01526a4fb",
}

function M.config()
  local status_ok, project = pcall(require, "project_nvim")
  if not status_ok then
    print 'Project Nvim not loaded'
    return
  end

  project.setup({
    active = true,
    on_config_done = nil,
    manual_mode = false,

    ---@usage Methods of detecting the root directory
    --- Allowed values: **"lsp"** uses the native neovim lsp
    --- **"pattern"** uses vim-rooter like glob pattern matching. Here
    --- order matters: if one is not detected, the other is used as fallback. You
    --- can also delete or rearangne the detection methods.
    --- NOTE: lsp detection will get annoying with multiple langs in one project
    detection_methods = { "pattern" },

    ---@usage patterns used to detect root dir, when **"pattern"** is in detection_methods
    patterns = { "^Repositories" --[[ , ".git", "Makefile", "package.json" ]] },
    show_hidden = true,
    silent_chdir = true,
    ignore_lsp = {},

    ---@type string
    ---@usage path to store the project history for use in telescope
    datapath = vim.fn.stdpath("data"),
  })

  local tele_status_ok, telescope = pcall(require, "telescope")
  if not tele_status_ok then
    return
  end

  telescope.load_extension('projects')
end

return M
