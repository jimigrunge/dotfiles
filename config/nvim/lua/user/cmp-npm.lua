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
