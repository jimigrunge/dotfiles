local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
  print 'Impatient not loaded'
  return
end

impatient.enable_profile()
