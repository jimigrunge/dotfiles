local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  commit = "566b7036f717f3d676362742630518a47f132fff",
}

function M.config()
  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    print 'Lualine not loaded'
    return
  end

  local icons = require "user.icons"

  local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end

  local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = {
      error = icons.diagnostics.BoldError,
      warn = icons.diagnostics.BoldWarning,
    },
    colored = false,
    update_in_insert = false,
    always_visible = true,
  }

  local diff = {
    "diff",
    colored = true,
    diff_color = {
      -- Same color values as the general color option can be used here.
      added    = 'DiffAdd',  -- Changes the diff's added color
      modified = 'DiffChange', -- Changes the diff's modified color
      removed  = 'DiffDelete', -- Changes the diff's removed color you
    },
    symbols = {
      added = icons.git.LineAdded .. " ",
      modified = icons.git.LineModified .. " ",
      removed = icons.git.LineRemoved .. " ",
    }, -- changes diff symbols
    cond = hide_in_width
  }

  local mode = {
    "mode",
    icons_enabled = true,
    fmt = function(str)
      return " " .. str .. " "
    end,
  }

  local filetype = {
    "filetype",
    icons_enabled = true,
    icon = { align = 'right' },
  }

  local branch = {
    "branch",
    icons_enabled = true,
    icon = icons.git.Branch,
  }

  local location = {
    "location",
    padding = 2,
  }

  local filename = {
    "filename",
    file_status = true,
    path = 1, -- 0: Just the filename
    -- 1: Relative path
    -- 2: Absolute path
    -- 3: Absolute path, with tilde as the home directory
    shorting_target = 40,
    symbols = {
      modified = icons.git.LineAdded, -- Text to show when the file is modified.
      readonly = icons.git.FileIgnored, -- Text to show when the file is non-modifiable or readonly.
      unnamed = '[No Name]',          -- Text to show for unnamed buffers.
    }
  }

  local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end

  local navic = require("nvim-navic")

  lualine.setup({
    options = {
      icons_enabled = true,
      theme = "powerline_dark",
      component_separators = {
        left = icons.ui.DividerRight,
        right = icons.ui.DividerLeft,
      },
      section_separators = {
        left = icons.ui.BoldDividerRight,
        right = icons.ui.BoldDividerLeft,
      },
      disabled_filetypes = { "alpha", "dashboard", "toggleterm", "Outline" },
      always_divide_middle = true,
      global_status = true,
    },
    sections = {
      lualine_a = { mode },
      lualine_b = { branch, diff, diagnostics },
      lualine_c = {
        filename,
        { navic.get_location, cond = navic.is_available },
        -- 'buffers',
      },

      lualine_x = {
        {
          'copilot',
          show_colors = true,
        }, spaces, "encoding", filetype,
      },
      lualine_y = { location },
      lualine_z = { "filesize", "progress" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  })


end

return M
