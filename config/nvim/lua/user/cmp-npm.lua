-- A npm completion source for cmp.
local M = {
  "David-Kunz/cmp-npm",
  dependencies = { 'nvim-lua/plenary.nvim' },
  ft = "json",
  commit = "2337f109f51a09297596dd6b538b70ccba92b4e4",
}

function M.config()
  local cmp_status_ok, cmp_npm = pcall(require, "cmp-npm")
  if not cmp_status_ok then
    print("cmp_npm not loaded")
    return
  end

  cmp_npm.setup({
    ignore = {
      'beta',
      'rc',
    }
  })
end

return M
