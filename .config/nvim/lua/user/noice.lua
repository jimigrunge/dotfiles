-- A plugin for playing music in neovim.
local M = {
  "folke/noice.nvim",
  commit = "eaed6cc9c06aa2013b5255349e4f26a6b17ab70f",
  -- commit = "bf67d70bd7265d075191e7812d8eb42b9791f737",
  -- event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify",
  },
}

function M.config()
  local status_ok, noice = pcall(require, "noice")
  if not status_ok then
    print 'Noice not loaded'
    return
  end

  local icons = require "user.icons"
  local wk = require "which-key"
  wk.add({
    {"<leader>ne", "<cmd>Noice errors<cr>", desc="Noice Errors" },
    {"<leader>nh", "<cmd>Noice history<cr>", desc="Noice History" },
    {"<leader>nl", "<cmd>Noice last<cr>", desc="Noice Message Last" },
    {"<leader>nn", "<cmd>Noice<cr>", desc="Noice Messages" },
    {"<leader>nt", "<cmd>Noice telescope<cr>", desc="Noice Telescope" },
  }, opts)

  noice.setup({
    cmdline = {
      enabled = true,         -- enables the Noice cmdline UI
      view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
      opts = {},              -- global options for the cmdline. See section on views
      format = {
        -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
        -- view: (default is cmdline view)
        -- opts: any options passed to the view
        -- icon_hl_group: optional hl_group for the icon
        -- title: set to anything or empty string to hide
        cmdline = { pattern = "^:", title = "CmdLine", icon = icons.ui.BoldDoubleChevronRight, lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = icons.ui.BoldSearch .. " " .. icons.ui.DoubleChevronDown, lang = "regex" },
        search_up = { kind = "search", pattern = "^%?", icon = icons.ui.BoldSearch .. " " .. icons.ui.DoubleChevronUp, lang = "regex" },
        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = icons.kind.Lua, lang = "lua" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = icons.diagnostics.BoldQuestion },
        input = {}, -- Used by input()
        -- lua = false, -- to disable a format, set to `false`
      },
    },
    messages = {
      -- NOTE: If you enable messages, then the cmdline is enabled automatically.
      -- This is a current Neovim limitation.
      enabled = true,              -- enables the Noice messages UI
      view = "notify",             --"virtualtext", --"notify",           -- default view for messages
      view_error = "notify",       -- view for errors
      view_warn = "notify",        -- view for warnings
      view_history = "messages",   -- view for :messages
      view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
    },
    popupmenu = {
      enabled = true,  -- enables the Noice popupmenu UI
      ---@type 'nui'|'cmp'
      backend = "nui", -- backend to use to show regular cmdline completions
      -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
      kind_icons = {}, -- set to `false` to disable icons
    },
    -- default options for require('noice').redirect
    -- see the section on Command Redirection
    redirect = {
      view = "popup",
      filter = { event = "msg_show" },
    },
    -- You can add any custom commands below that will be available with `:Noice command`
    commands = {
      history = {
        -- options for the message history that you get with `:Noice`
        view = "popup", -- "split",
        opts = { enter = true, format = "details" },
        filter = {
          any = {
            { event = "notify" },
            { error = true },
            { warning = true },
            { event = "msg_show", kind = { "" } },
            { event = "lsp",      kind = "message" },
          },
        },
      },
      -- :Noice last
      last = {
        view = "popup",
        opts = { enter = true, format = "details" },
        filter = {
          any = {
            { event = "notify" },
            { error = true },
            { warning = true },
            { event = "msg_show", kind = { "" } },
            { event = "lsp",      kind = "message" },
          },
        },
        filter_opts = { count = 1 },
      },
      -- :Noice errors
      errors = {
        -- options for the message history that you get with `:Noice`
        view = "popup",
        opts = { enter = true, format = "details" },
        filter = { error = true },
        filter_opts = { reverse = true },
      },
    },
    notify = {
      -- Noice can be used as `vim.notify` so you can route any notification like other messages
      -- Notification messages have their level and other properties set.
      -- event is always "notify" and kind can be any log level as a string
      -- The default routes will forward notifications to nvim-notify
      -- Benefit of using Noice for this is the routing and consistent history view
      enabled = true,
      view = "notify",
    },
    lsp = {
      progress = {
        enabled = false,
        -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
        -- See the section on formatting for more details on how to customize.
        format = "lsp_progress",
        format_done = "lsp_progress_done",
        throttle = 1000 / 30, -- frequency to update lsp progress message
        view = "mini",
      },
      override = {
        -- override the default lsp markdown formatter with Noice
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        -- override the lsp markdown formatter with Noice
        ["vim.lsp.util.stylize_markdown"] = true,
        -- override cmp documentation with Noice (needs the other options to work)
        ["cmp.entry.get_documentation"] = true,
      },
      hover = {
        enabled = true,
        silent = false, -- set to true to not show a message if hover is not available
        view = nil,     -- when nil, use defaults from documentation
        opts = {},      -- merged with defaults from documentation
      },
      signature = {
        enabled = true,
        auto_open = {
          enabled = true,
          trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
          luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
          throttle = 50,  -- Debounce lsp signature help request by 50ms
        },
        view = nil,       -- when nil, use defaults from documentation
        opts = {},        -- merged with defaults from documentation
      },
      message = {
        -- Messages shown by lsp servers
        enabled = true,
        view = "notify",
        opts = {},
      },
      -- defaults for hover and signature help
      documentation = {
        view = "hover",
        opts = {
          lang = "markdown",
          replace = true,
          render = "plain",
          format = { "{message}" },
          win_options = { concealcursor = "n", conceallevel = 3 },
        },
      },
    },
    markdown = {
      hover = {
        ["|(%S-)|"] = vim.cmd.help,                       -- vim help links
        ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
      },
      highlights = {
        ["|%S-|"] = "@text.reference",
        ["@%S+"] = "@parameter",
        ["^%s*(Parameters:)"] = "@text.title",
        ["^%s*(Return:)"] = "@text.title",
        ["^%s*(See also:)"] = "@text.title",
        ["{%S-}"] = "@parameter",
      },
    },
    health = {
      checker = true, -- Disable if you don't want health checks to run
    },
    smart_move = {
      -- noice tries to move out of the way of existing floating windows.
      enabled = true, -- you can disable this behaviour here
      -- add any filetypes here, that shouldn't trigger smart move.
      excluded_filetypes = {
        "cmp_menu",
        "cmp_docs",
        "notify",
        "icon-picker"
      },
    },
    presets = {
      -- you can enable a preset by setting it to true, or a table that will override the preset config
      -- you can also add custom presets that you can enable/disable with enabled=true
      bottom_search = false,         -- use a classic bottom cmdline for search
      command_palette = false,       -- position the cmdline and popupmenu together
      long_message_to_split = false, -- long messages will be sent to a split
      inc_rename = false,            -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true,         -- add a border to hover docs and signature help
    },
    throttle = 1000 / 30,            -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
    views = {
      -- -------------------
      -- Clean command popup
      -- -------------------
      -- cmdline_popup = {
      --   border = {
      --     style = "none",
      --     padding = { 2, 3 },
      --   },
      --   filter_options = {},
      --   win_options = {
      --     winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      --   },
      -- },
      -- -------------------
      -- Titled popup
      -- -------------------
      cmdline_popup = {
        position = {
          row = "50%", --15,
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
      },
      -- popupmenu = {
      --   relative = "editor",
      --   position = {
      --     row = 8,
      --     col = "50%",
      --   },
      --   size = {
      --     width = 60,
      --     height = 10,
      --   },
      --   border = {
      --     style = "rounded",
      --     padding = { 0, 1 },
      --   },
      --   win_options = {
      --     winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      --   },
      -- },
    }, ---@see section on views
    routes = {
      {
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },
            { find = '; after #%d+' },
            { find = '; before #%d+' },
            { find = '%d fewer lines' },
            { find = '%d more lines' },
          },
        },
        opts = { skip = true },
      }
    },           --- @see section on routes
    status = {}, --- @see section on statusline components
    format = {}, --- @see section on formatting
  })

  require("telescope").load_extension("noice")
end

return M
