local status_ok, gitlinker = pcall(require, "gitlinker")
if not status_ok then
  print 'Git Linker not loaded'
  return
end

gitlinker.setup({
  message = false,
  console_log = false
})
