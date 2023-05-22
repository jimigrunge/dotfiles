local status_ok, notify = pcall(require, 'notify')
if not status_ok then
  print 'Notify not loaded'
	return
end

notify.setup({
  render = 'minimal',
  timeout = 1500
})
