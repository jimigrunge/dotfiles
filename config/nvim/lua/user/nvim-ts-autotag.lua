local status_ok, tsautotag = pcall(require, 'nvim-ts-autotag')
if not status_ok then
  print 'TS Autotag not loaded'
	return
end

tsautotag.setup {
  filetypes = { "html" , "xml", "xsl", "vue", "tsx", "jsx" },
}
