local M = {
  "mfussenegger/nvim-dap",
  commit = "9adbfdca13afbe646d09a8d7a86d5d031fb9c5a5",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      commit = "d845ebd798ad1cf30aa4abd4c4eff795cdcfdd4f",
    },
    {
      "mxsdev/nvim-dap-vscode-js",
      dependencies = { "mfussenegger/nvim-dap" },
      commit = "03bd29672d7fab5e515fc8469b7d07cc5994bbf6",
    },
  },
}

function M.config()
  -- [[ Consider lookig at LunarVim configuration for DAP ]]
  -- [[ https://github.com/LunarVim/LunarVim/blob/rolling/lua/lvim/core/dap.lua ]]
  local icons = require "user.icons"
  local dap_status_ok, dap = pcall(require, "dap")
  if not dap_status_ok then
    print("Dap not loaded")
    return
  end
  local dap_ui_status_ok, dapui = pcall(require, "dapui")
  if not dap_ui_status_ok then
    print("DapUI not loaded")
    return
  end
  local dap_vsc_status_ok, dapvscjs = pcall(require, "dap-vscode-js")
  if not dap_vsc_status_ok then
    print("DapVscodeJs not loaded")
    return
  end
  local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")

  local wk = require "which-key"
  wk.register {
    ["<leader>db"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle [B]reakpoint" },
    ["<leader>dB"] = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Conditional [B]reakpoint" },
    ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "[C]ontinue" },
    ["<leader>de"] = { "<cmd>lua require'dapui'.eval(<expression>)<cr>", "[E]val Expression" },
    ["<leader>di"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step [I]nto" },
    ["<leader>dl"] = { "<cmd>lua require'dap'.run_last()<cr>", "Run [L]ast" },
    ["<leader>do"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step [O]ver" },
    ["<leader>dO"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step [O]ut" },
    ["<leader>dr"] = { "<cmd>lua require'dap'.repl.open()<cr>", "[R]EPL" },
    ["<leader>dt"] = { "<cmd>lua require'dap'.terminate()<cr>", "[T]erminate" },
    ["<leader>du"] = { "<cmd>lua require'dapui'.toggle()<cr>", "Dap[U]i Toggle" },
  }

  vim.fn.sign_define("DapBreakpoint",
    { text = icons.diagnostics.Debug, texthl = "DiagnosticSignError", linehl = "", numhl = "" })

  dapui.setup({
    icons = {
      expanded = icons.ui.BoldDividerDown,
      collapsed = icons.ui.BoldDividerRight,
      current_frame = icons.ui.BoldDividerRight,
    },
    mappings = {
      -- Use a table to apply multiple mappings
      -- expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    element_mappings = {},
    expand_lines = true,
    force_buffers = true,
    floating = {
      max_height = nil,
      max_width = nil,
      border = "single",
      mappings = {
        ["close"] = { "q", "<Esc>" },
      },
    },
    controls = {
      enabled = vim.fn.exists("+winbar") == 1,
      element = "repl",
      icons = {
        pause = icons.ui.Pause,
        play = icons.ui.Play,
        step_into = icons.ui.StepInto,
        step_over = icons.ui.StepOver,
        step_out = icons.ui.StepOut,
        step_back = icons.ui.StepBack,
        run_last = icons.ui.RunLast,
        terminate = icons.ui.Terminate,
        disconnect = icons.ui.Disconnect,
      },
    },
    render = {
      max_type_length = nil, -- Can be integer or nil.
      max_value_lines = 100, -- Can be integer or nil.
      indent = 1,
    },
    layouts = {
      {
        elements = {
          "scopes",
          "breakpoints",
          "stacks",
          "watches",
        },
        size = 40,
        position = "left",
      },
      {
        elements = {
          "repl",
          "console",
        },
        size = 10,
        position = "bottom",
      },
    },
  })

  dapvscjs.setup({
    node_path = os.getenv("NODE_PATH") or "node",
    debugger_path = mason_path .. "packages/js-debug-adapter", -- Path to vscode-js-debug installation.
    debugger_cmd = { "js-debug-adapter" },                     -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    log_file_path = vim.fn.stdpath('cache') .. "/dap_vscode_js.log",
    log_file_level = vim.log.levels.ERROR,
    log_console_level = vim.log.levels.ERROR,
    adapters = { "pwa-node", "pwa-chrome" }, -- which adapters to register in nvim-dap
  })

  -- JavaScript Debug Adapter
  -- ---------------------------------------
  dap.configurations.javascript = {
    {
      name = 'Launch',
      type = 'pwa-node',
      request = 'launch',
      program = '${file}',
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      name = 'Attach to node process',
      type = 'pwa-node',
      request = 'attach',
      rootPath = '${workspaceFolder}',
      processId = require('dap.utils').pick_process,
    }
  }
  dap.configurations.typescript = {
    {
      name = 'Launch',
      type = 'pwa-node',
      request = 'launch',
      program = '${file}',
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      name = 'Attach to node process',
      type = 'pwa-node',
      request = 'attach',
      rootPath = '${workspaceFolder}',
      processId = require('dap.utils').pick_process,
    }
  }
  dap.configurations.typescriptreact = {
    {
      name = 'Launch',
      type = 'pwa-node',
      request = 'launch',
      program = '${file}',
      rootPath = '${workspaceFolder}',
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
      protocol = 'inspector',
      console = 'integratedTerminal',
    },
    {
      name = 'Attach to node process',
      type = 'pwa-node',
      request = 'attach',
      rootPath = '${workspaceFolder}',
      processId = require('dap.utils').pick_process,
    }
  }

  -- Node Debug Adapter
  -- ---------------------------------------
  --[[ dap.adapters.node2 = { ]]
  --[[   type = 'executable', ]]
  --[[   command = 'node', ]]
  --[[   args = {mason_path .. 'packages/node-debug2-adapter/out/src/nodeDebug.js'}, ]]
  --[[ } ]]
  --[[ dap.configurations.javascript = { ]]
  --[[   { ]]
  --[[     name = 'Launch', ]]
  --[[     type = 'node2', ]]
  --[[     request = 'launch', ]]
  --[[     program = '${file}', ]]
  --[[     cwd = vim.fn.getcwd(), ]]
  --[[     sourceMaps = true, ]]
  --[[     protocol = 'inspector', ]]
  --[[     console = 'integratedTerminal', ]]
  --[[   }, ]]
  --[[   { ]]
  --[[     -- For this to work you need to make sure the node process is started with the `--inspect` flag. ]]
  --[[     name = 'Attach to process', ]]
  --[[     type = 'node2', ]]
  --[[     request = 'attach', ]]
  --[[     processId = require'dap.utils'.pick_process, ]]
  --[[   }, ]]
  --[[ } ]]
  --[[]]
  --[[ dap.adapters.chrome = { ]]
  --[[     type = "executable", ]]
  --[[     command = "node", ]]
  --[[     args = {mason_path .. 'packages/js-debug-adapter/out/src/debugServer.js'} ]]
  --[[ } ]]

  -- Chrome Debug Adapter
  -- ---------------------------------------
  --[[ dap.configurations.javascriptreact = { -- change this to javascript if needed ]]
  --[[     { ]]
  --[[         type = "chrome", ]]
  --[[         request = "attach", ]]
  --[[         program = "${file}", ]]
  --[[         cwd = vim.fn.getcwd(), ]]
  --[[         sourceMaps = true, ]]
  --[[         protocol = "inspector", ]]
  --[[         port = 9222, ]]
  --[[         webRoot = "${workspaceFolder}" ]]
  --[[     } ]]
  --[[ } ]]
  --[[]]
  --[[ dap.configurations.typescriptreact = { -- change to typescript if needed ]]
  --[[     { ]]
  --[[         type = "chrome", ]]
  --[[         request = "attach", ]]
  --[[         program = "${file}", ]]
  --[[         cwd = vim.fn.getcwd(), ]]
  --[[         sourceMaps = true, ]]
  --[[         protocol = "inspector", ]]
  --[[         port = 9222, ]]
  --[[         webRoot = "${workspaceFolder}" ]]
  --[[     } ]]
  --[[ } ]]

  -- PHP Debug Adapter
  -- ---------------------------------------
  -- dap.adapters.php = {
  --   type = "executable",
  --   command = "node",
  --   args = { mason_path .. "packages/php-debug-adapter/extension/out/phpDebug.js" },
  -- }
  -- dap.configurations.php = {
  --   {
  --     name = "Listen for Xdebug",
  --     type = "php",
  --     request = "launch",
  --     port = 9003,
  --   },
  --   {
  --     name = "Debug currently open script",
  --     type = "php",
  --     request = "launch",
  --     port = 9003,
  --     cwd = "${fileDirname}",
  --     program = "${file}",
  --     runtimeExecutable = "php",
  --   },
  -- }

  dap.listeners.after.event_initialized.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
end

return M
