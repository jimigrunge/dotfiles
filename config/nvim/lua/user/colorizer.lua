local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  print 'Colorizer not loaded'
  return
end

colorizer.setup({
  'css',
  'javascript',
  html = {
    mode = 'background',
  }
})
