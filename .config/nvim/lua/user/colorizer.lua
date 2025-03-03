-- A plugin for colorizing hex codes in neovim.
local M = {
  "norcalli/nvim-colorizer.lua",
  commit = "a065833f35a3a7cc3ef137ac88b5381da2ba302e",
  -- commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6",
}

function M.config()
  local status_ok, colorizer = pcall(require, "colorizer")
  if not status_ok then
    print 'Colorizer not loaded'
    return
  end

  local icons = require "user.icons"

  colorizer.setup({
    "*",
    user_default_options = {
      RGB = true,          -- #RGB hex codes
      RRGGBB = true,       -- #RRGGBB hex codes
      names = true,        -- "Name" codes like Blue or blue
      RRGGBBAA = false,    -- #RRGGBBAA hex codes
      AARRGGBB = false,    -- 0xAARRGGBB hex codes
      rgb_fn = true,       -- CSS rgb() and rgba() functions
      hsl_fn = false,      -- CSS hsl() and hsla() functions
      css = true,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true,      -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Available modes for `mode`: foreground, background,  virtualtext
      mode = "background", -- Set the display mode.
      -- Available methods are false / true / "normal" / "lsp" / "both"
      -- True is same as normal
      tailwind = true,                                -- Enable tailwind colors
      -- parsers can contain values used in |user_default_options|
      sass = { enable = true, parsers = { "css" }, }, -- Enable sass colors
      virtualtext = icons.ui.Block,
      -- update color values even if buffer is not focused
      -- example use: cmp_menu, cmp_docs
      always_update = false
    },
    -- all the sub-options of filetypes apply to buftypes
    buftypes = {
      -- exclude prompt and popup buftypes from highlight
      "!prompt",
      "!popup",
    },
  })
end

return M
