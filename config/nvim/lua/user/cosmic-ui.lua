local M = {
  "CosmicNvim/cosmic-ui",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  commit = "c0b14531999f2bfef3d927c4dcd57a1a8fed5ee9",
}

function M.config()
  local status_ok, cosmic_ui = pcall(require, "cosmic-ui")
  if not status_ok then
    print 'Cosmic UI not loaded'
    return
  end

  local wk = require "which-key"
  wk.register {
    ["<leader>lr"] = { "<cmd>lua require('cosmic-ui').rename()<cr>", "[R]ename" },
  }

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
end

return M
