local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  print 'Bufferline not loaded'
  return
end

local icons = require "user.icons"

bufferline.setup {
  highlights = {},
  options = {
    mode = "buffers",
    style_preset = bufferline.style_preset.default,
    themable = true,
    numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    indicator = {
      -- icon = "▎", -- this should be omitted if indicator style is not 'icon'
      style = 'underline', -- icon | underline | none
    },
    buffer_close_icon = icons.ui.BoldClose,
    modified_icon = icons.ui.Pencil,
    close_icon = icons.ui.BoldClose,
    left_trunc_marker = icons.ui.ArrowCircleLeft,
    right_trunc_marker = icons.ui.ArrowCircleRight,
    max_name_length = 30,
    max_prefix_length = 30,   -- prefix used when a buffer is de-duplicated
    truncate_names = true,    -- whether or not tab names should be truncated
    tab_size = 21,
    diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, _, context)
      local icon = level:match("error") and icons.diagnostics.Error or icons.diagnostics.BoldError
      if context.buffer:current() then
        return ""
      end
      return " " .. icon .. count
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center", -- "left" | "center" | "right"
        separator = true,
        highlight = "Directory",
        padding = 1
      }
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    get_element_icon = function(element)
      local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
      return icon, hl
    end,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
    persist_buffer_sort = true,   -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
    separator_style = "slant",  --  "slant" |"padded_slant" | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    hover = {
      enabled = true,
      delay = 200,
      reveal = { 'close' }
    },
    sort_by = 'insert_after_current',
  },
}
