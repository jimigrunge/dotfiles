local status_ok, lightbulb = pcall(require, 'nvim-lightbulb')
if not status_ok then
  print 'Lightbulb not loaded'
	return
end

lightbulb.setup {
  ignore = {"null-ls"},
  autocmd = {
    enabled = true,
  }
}
