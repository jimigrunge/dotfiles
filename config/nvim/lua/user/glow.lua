local status_ok, glow = pcall(require, 'glow')
if not status_ok then
  print 'Glow not loaded'
  return
end

glow.setup({
  install_path = vim.env.HOME .. "/.local/bin", -- default path for installing glow binary
  glow_path = vim.env.HOME .. "/.local/bin/glow",
  border = "rounded",
  style = 'dark',
  pager = false,
  width = 120,
  height = 180,
  width_ratio = 0.7,
  height_ratio = 0.9,
})
