-- A plugin for creating lightweight floating statuslines
local M = {
  "b0o/incline.nvim",
}

function M.config()
  local status_ok, incline = pcall(require, "incline")
  if not status_ok then
    print "Incline not loaded"
    return
  end

  -- local helpers = require 'incline.helpers'
  local devicons = require 'nvim-web-devicons'

  local config = {
    render = function(props)
      local uicons = require "user.icons"
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
      if filename == '' then
        filename = '[No Name]'
      end
      local ft_icon, ft_color = devicons.get_icon_color(filename)

      local function get_git_diff()
        local icons = {
          removed = uicons.git.LineRemoved .. ' ',
          changed = uicons.git.LineModified .. ' ',
          added = uicons.git.LineAdded .. ' ',
        }
        local signs = vim.b[props.buf].gitsigns_status_dict
        local labels = {}
        if signs == nil then
          return labels
        end
        for name, icon in pairs(icons) do
          if tonumber(signs[name]) and signs[name] > 0 then
            table.insert(labels, { icon .. signs[name] .. ' ', group = 'Diff' .. name })
          end
        end
        if #labels > 0 then
          table.insert(labels, { uicons.ui.LineDashedMiddle .. ' ' })
        end
        return labels
      end

      local function get_diagnostic_label()
        local icons = {
          error = uicons.ui.BoldClose .. ' ',
          warn = uicons.diagnostics.BoldWarning .. ' ',
          info = uicons.diagnostics.BoldInformation .. '',
          hint = uicons.diagnostics.BoldHint .. ' ',
        }
        local label = {}

        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
          if n > 0 then
            table.insert(label, { icon .. n .. ' ', group = 'DiagnosticSign' .. severity })
          end
        end
        if #label > 0 then
          table.insert(label, { uicons.ui.LineDashedMiddle .. ' ' })
        end
        return label
      end

      return {
        {
          -- get_diagnostic_label(),
        },
        { get_git_diff() },
        { (ft_icon or '') .. ' ', guifg = ft_color, guibg = 'none' },
        { filename .. ' ', gui = vim.bo[props.buf].modified and 'bold,italic' or 'bold' },
        {
          uicons.ui.LineDashedMiddle, -- .. uicons.kind.Window .. vim.api.nvim_win_get_number(props.win),
          group = 'DevIconWindows',
        },
      }
    end,
  }

  -- your config here
  incline.setup(config)
end

return M
