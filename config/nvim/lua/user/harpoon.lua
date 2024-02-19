local M = {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" }
}

function M.config()
  local status_ok, harpoon = pcall(require, "harpoon")
  if not status_ok then
    print "Harpoon not loaded"
    return
  end

  ---@diagnostic disable-next-line: missing-fields, missing-parameter
  harpoon.setup({
    settings = {
      save_on_toggle = true,
    },
    display = {
      ui_width_ratio = 0.8,
    }
  })
  -- Open in splits or tab
  harpoon:extend({
    UI_CREATE = function(cx)
      vim.keymap.set("n", "<C-v>", function()
        harpoon.ui:select_menu_item({ vsplit = true })
      end, { buffer = cx.bufnr })

      -- vim.keymap.set("n", "<C-x>", function()
      --   harpoon.ui:select_menu_item({ split = true })
      -- end, { buffer = cx.bufnr })

      -- vim.keymap.set("n", "<C-t>", function()
      --   harpoon.ui:select_menu_item({ tabedit = true })
      -- end, { buffer = cx.bufnr })
    end,
  })

  -- Key bindings
  vim.keymap.set("n", "<leader>he", function()
      harpoon.ui:toggle_quick_menu(harpoon:list(), {
        border = "rounded",
        title = " Harpoon ",
        title_pos = "center",
        ui_width_ratio = 0.7,
      })
    end,
    { desc = "[E] Open", })
  vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end, { desc = "[A]ppend" })
  vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end, { desc = "[R]emove" })
end

return M
