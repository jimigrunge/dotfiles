local status_ok, devicons = pcall(require, "nvim-web-devicons")
if not status_ok then
  print 'Devicons not loaded'
  return
end

local icons = require "user.icons"

devicons.setup {
  -- Overrides for icons causing display issues in nvim-tree sue to ltr display of fonts.
  -- There is a posible PR in the works from "jdrouhard" to fix this
  override = {
    [".babelrc"] = {
      icon = icons.ui.Comment, -- "", -- actual utf-8 encoded codepoints instead, this is for demonstration
      color = "#FFFFFF",
      cterm_color = "185",
      name = "Bablerc"
    },
    ["R"] = {
      icon = icons.ui.List,
      color = "#358a5b",
      cterm_color = "65",
      name = "R",
    },
    ["r"] = {
      icon = icons.ui.List,
      color = "#358a5b",
      cterm_color = "65",
      name = "R",
    },
    ["svg"] = {
      icon = "",
      color = "#FFFFFF",
      cterm_color = "215",
      name = "Svg"
    },
    ["tbc"] = {
      icon = icons.ui.List,
      color = "#1e5cb3",
      cterm_color = "67",
      name = "Tcl",
    },
    ["tcl"] = {
      icon = icons.ui.List,
      color = "#1e5cb3",
      cterm_color = "67",
      name = "Tcl",
    },
    tex = {
      icon = icons.ui.List,
      color = "#FFFFFF",
      cterm_color = "58",
      name = "Tex"
    },
    ["webpack"] = {
      icon = icons.ui.Package,
      color = "#519aba",
      cterm_color = "67",
      name = "Webpack",
    },
    ["sol"] = {
      icon = icons.ui.List,
      color = "#519aba",
      cterm_color = "67",
      name = "Solidity",
    },
  },
  default = true,
};
