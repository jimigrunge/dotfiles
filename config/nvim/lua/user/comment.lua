local M = {
  "numToStr/Comment.nvim",
  commit = "0236521ea582747b58869cb72f70ccfa967d2e89",
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      commit = "1277b4a1f451b0f18c0790e1a7f12e1e5fdebfee",
    }
  }
}

function M.config()
  local status_ok, comment = pcall(require, "Comment")
  if not status_ok then
    print 'Comment not loaded'
    return
  end
  local ts_status_ok, ts_plugin = pcall(require, "ts_context_commentstring")
  if not ts_status_ok then
    print 'ts_context_commentstring not loaded'
    return
  end

  local wk = require "which-key"
  wk.register {
    ["<leader>/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment" },
  }
  wk.register {
    ["<leader>/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment", mode = "v" },
  }

  ---@diagnostic disable-next-line: missing-fields
  ts_plugin.setup {
    enable_autocmd = false,
  }
  vim.g.skip_ts_context_commentstring_module = true

  comment.setup {
    padding = true,
    sticky = true,
    ---@diagnostic disable-next-line: assign-type-mismatch
    ignore = nil,
    toggler = {
      line = 'gcc',
      block = 'gbc',
    },
    opleader = {
      line = 'gc',
      block = 'gb',
    },
    extra = {
      above = 'gcO',
      below = 'gco',
      eol = 'gcA',
    },
    mappings = {
      basic = true,
      extra = true,
    },
    ---@diagnostic disable-next-line: assign-type-mismatch
    post_hook = nil,
    ---@diagnostic disable-next-line: assign-type-mismatch
    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
  }
end

return M
