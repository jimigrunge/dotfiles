local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  print 'Bufferline not loaded'
  return
end

bufferline.setup {
  options = {
    themable = true,
    numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator = {
      style = 'icon',
      icon ="▎"
    },
    buffer_close_icon = "",
    -- buffer_close_icon = '',
    modified_icon = "●",
    close_icon = "",
    -- close_icon = '',
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 30,
    max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
    tab_size = 21,
    diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      if context.buffer:current() then
        return ""
      end
      return " " .. icon .. count
    end,
    offsets = { { filetype = "File Explorer", text = "", padding = 1 } },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "slant", --  "slant" |"padded_slant" | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = false,
    always_show_bufferline = true,
  },
  --[[ highlights = { ]]
  --[[   fill = { ]]
  --[[     fg = { attribute = "fg", highlight = "TabLine" }, ]]
  --[[     bg = { attribute = "bg", highlight = "TabLine" }, ]]
  --[[   }, ]]
  --[[   background = { ]]
  --[[     fg = { attribute = "fg", highlight = "TabLine" }, ]]
  --[[     bg = { attribute = "bg", highlight = "TabLine" }, ]]
  --[[   }, ]]
  --[[]]
  --[[   buffer_selected = { ]]
  --[[     fg = {attribute='fg',highlight='LspDiagnosticsDefaultHint'}, ]]
  --[[     -- bg = {attribute='bg',highlight='#0000ff'}, ]]
  --[[     bg = { attribute = "bg", highlight = "TabLineSel" }, ]]
  --[[     bold = true ]]
  --[[   }, ]]
  --[[   buffer_visible = { ]]
  --[[     fg = { attribute = "fg", highlight = "TabLine" }, ]]
  --[[     bg = { attribute = "bg", highlight = "TabLine" }, ]]
  --[[   }, ]]
  --[[]]
  --[[   diagnostic_selected = { ]]
  --[[     fg = {attribute='fg',highlight='LspDiagnosticsDefaultHint'}, ]]
  --[[     bg = {attribute='bg',highlight='#00ff00'}, ]]
  --[[     bold = true ]]
  --[[   }, ]]
  --[[   diagnostic_visible = { ]]
  --[[     fg = {attribute='fg',highlight='LspDiagnosticsDefaultHint'}, ]]
  --[[     bg = {attribute='bg',highlight='#00ff00'}, ]]
  --[[   }, ]]
  --[[]]
  --[[   info_selected = { ]]
  --[[     fg = {attribute='fg',highlight='LspDiagnosticsDefaultInfo'}, ]]
  --[[     bg = {attribute='bg',highlight='#73D7FF'}, ]]
  --[[     bold = true ]]
  --[[   }, ]]
  --[[   info_visible = { ]]
  --[[     fg = {attribute='fg',highlight='LspDiagnosticsDefaultInfo'}, ]]
  --[[     bg = {attribute='bg',highlight='#73D7FF'}, ]]
  --[[   }, ]]
  --[[]]
  --[[   warning_selected = { ]]
  --[[     fg = {attribute='fg',highlight='LspDiagnosticsDefaultWarn'}, ]]
  --[[     bg = {attribute='bg',highlight='#ffff00'}, ]]
  --[[     bold = true ]]
  --[[   }, ]]
  --[[   warning_visible = { ]]
  --[[     fg = {attribute='fg',highlight='LspDiagnosticsDefaultWarn'}, ]]
  --[[     bg = {attribute='bg',highlight='#ffff00'}, ]]
  --[[   }, ]]
  --[[]]
  --[[   error_selected = { ]]
  --[[     fg = {attribute='fg',highlight='LspDiagnosticsDefaultError'}, ]]
  --[[     bg = {attribute='bg',highlight='#ff0000'}, ]]
  --[[     bold = true ]]
  --[[   }, ]]
  --[[   error_visible = { ]]
  --[[     fg = {attribute='fg',highlight='LspDiagnosticsDefaultError'}, ]]
  --[[     bg = {attribute='bg',highlight='#ff0000'}, ]]
  --[[   }, ]]
  --[[]]
  --[[   close_button = { ]]
  --[[     fg = { attribute = "fg", highlight = "TabLine" }, ]]
  --[[     bg = { attribute = "bg", highlight = "TabLine" }, ]]
  --[[   }, ]]
  --[[   close_button_visible = { ]]
  --[[     fg = { attribute = "fg", highlight = "TabLine" }, ]]
  --[[     bg = { attribute = "bg", highlight = "TabLine" }, ]]
  --[[   }, ]]
  --[[   -- close_button_selected = { ]]
  --[[   --   fg = {attribute='fg',highlight='TabLineSel'}, ]]
  --[[   --   bg ={attribute='bg',highlight='TabLineSel'} ]]
  --[[   --   }, ]]
  --[[]]
  --[[   tab_selected = { ]]
  --[[     fg = { attribute = "fg", highlight = "Normal" }, ]]
  --[[     bg = { attribute = "bg", highlight = "Normal" }, ]]
  --[[   }, ]]
  --[[   tab = { ]]
  --[[     fg = { attribute = "fg", highlight = "TabLine" }, ]]
  --[[     bg = { attribute = "bg", highlight = "TabLine" }, ]]
  --[[   }, ]]
  --[[   tab_close = { ]]
  --[[     fg = { attribute = "fg", highlight = "TabLine" }, ]]
  --[[     bg = { attribute = "bg", highlight = "TabLine" }, ]]
  --[[   }, ]]
  --[[]]
  --[[   duplicate_selected = { ]]
  --[[     fg = { attribute = "fg", highlight = "TabLine" }, ]]
  --[[     bg = { attribute = "bg", highlight = "TabLine" }, ]]
  --[[     italic = true ]]
  --[[   }, ]]
  --[[   duplicate_visible = { ]]
  --[[     fg = { attribute = "fg", highlight = "TabLine" }, ]]
  --[[     bg = { attribute = "bg", highlight = "TabLine" }, ]]
  --[[     italic = true ]]
  --[[   }, ]]
  --[[   duplicate = { ]]
  --[[     fg = { attribute = "fg", highlight = "TabLine" }, ]]
  --[[     bg = { attribute = "bg", highlight = "TabLine" }, ]]
  --[[     italic = true ]]
  --[[   }, ]]
  --[[]]
  --[[   modified = { ]]
  --[[     fg = { attribute = "fg", highlight = "TabLine" }, ]]
  --[[     bg = { attribute = "bg", highlight = "TabLine" }, ]]
  --[[   }, ]]
  --[[   modified_selected = { ]]
  --[[     fg = { attribute = "fg", highlight = "Normal" }, ]]
  --[[     bg = { attribute = "bg", highlight = "Normal" }, ]]
  --[[   }, ]]
  --[[   modified_visible = { ]]
  --[[     fg = { attribute = "fg", highlight = "TabLine" }, ]]
  --[[     bg = { attribute = "bg", highlight = "TabLine" }, ]]
  --[[   }, ]]
  --[[]]
  --[[   separator = { ]]
  --[[     fg = { attribute = "bg", highlight = "TabLine" }, ]]
  --[[     bg = { attribute = "bg", highlight = "TabLine" }, ]]
  --[[   }, ]]
  --[[   separator_selected = { ]]
  --[[     fg = { attribute = "bg", highlight = "Normal" }, ]]
  --[[     bg = { attribute = "bg", highlight = "Normal" }, ]]
  --[[   }, ]]
  --[[   separator_visible = { ]]
  --[[     fg = {attribute='bg',highlight='TabLine'}, ]]
  --[[     bg = {attribute='bg',highlight='TabLine'} ]]
  --[[     }, ]]
  --[[   indicator_selected = { ]]
  --[[     -- fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" }, ]]
  --[[     -- fg = { attribute = "fg", highlight = "Normal" }, ]]
  --[[     -- bg = { attribute = "bg", highlight = "Normal" }, ]]
  --[[     fg = { attribute = "fg", highlight = "TabLine" }, ]]
  --[[     bg = { attribute = "bg", highlight = "TabLine" }, ]]
  --[[   }, ]]
  --[[ }, ]]
}
