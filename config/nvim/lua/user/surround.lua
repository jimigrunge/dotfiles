local status_ok, surround = pcall(require, 'surround')
if not status_ok then
  print 'Surround not loaded'
	return
end

surround.setup {
  mappings_style = "surround"
}
