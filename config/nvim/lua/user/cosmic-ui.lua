local status_ok, cosmic_ui = pcall(require, "cosmic-ui")
if not status_ok then
  print 'Cosmic UI not loaded'
  return
end

cosmic_ui.setup {
  -- 'single', 'double', 'rounded', 'solid', 'shadow'
  border_style = 'rounded',

  -- rename popup settings
  rename = {
    border = {
      highlight = 'FloatBorder',
      style = 'single',
      title = ' Rename ',
      title_align = 'left',
      title_hl = 'FloatBorder',
    },
    prompt = '> ',
    prompt_hl = 'Comment',
  },
  code_actions = {
    min_width = nil,
    border = {
      bottom_hl = 'FloatBorder',
      highlight = 'FloatBorder',
      style = 'single',
      title = 'Code Actions',
      title_align = 'center',
      title_hl = 'FloatBorder',
    },
  }
}
