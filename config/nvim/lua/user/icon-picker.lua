local M = {
  "ziontee113/icon-picker.nvim",
  commit = "3ee9a0ea9feeef08ae35e40c8be6a2fa2c20f2d3",
}

function M.config()
  local status_ok, iconpicker = pcall(require, "icon-picker")
  if not status_ok then
    print 'Icon Picker not loaded'
    return
  end

  local wk = require "which-key"
  wk.register {
    ["<leader>spa"] = { "<cmd>IconPickerInsert alt_font<cr>", "[A]lt Font Picker" },
    ["<leader>spe"] = { "<cmd>IconPickerInsert emoji<cr>", "[E]moji Picker" },
    ["<leader>spE"] = { "<cmd>PickEverything alt_font nerd_font symbols emoji<cr>", "[E]verything Picker" },
    ["<leader>spi"] = { "<cmd>IconPickerInsert nerd_font<cr>", "[I]con Picker" },
    ["<leader>sph"] = { "<cmd>IconPickerInsert html_colors<cr>", "[H]tml Color Picker" },
    ["<leader>sps"] = { "<cmd>IconPickerInsert symbols<cr>", "[S]ymbol Picker" },
  }
  -- KEYMAP("i", "<C-c><C-a>", "<cmd>IconPickerInsert alt_font<cr>", KEYOPTS)
  -- KEYMAP("i", "<C-c><C-e>", "<cmd>IconPickerInsert emoji<cr>", KEYOPTS)
  -- KEYMAP("i", "<C-c><C-E>", "<cmd>PickEverything alt_font nerd_font symbols emoji<cr>", KEYOPTS)
  -- KEYMAP("i", "<C-c><C-f>", "<cmd>IconPickerInsert nerd_font<cr>", KEYOPTS)
  -- KEYMAP("i", "<C-c><C-s>", "<cmd>IconPickerInsert symbols<cr>", KEYOPTS)

  iconpicker.setup({
    disable_legacy_commands = true
  })
end

return M
