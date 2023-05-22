-- [[ Consider lookig at LunarVim configuration for DAP ]]
-- [[ https://github.com/LunarVim/LunarVim/blob/rolling/lua/lvim/core/dap.lua ]]
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

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dapui.setup({
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

dap.adapters.php = {
	type = "executable",
	command = "node",
	args = { mason_path .. "packages/php-debug-adapter/extension/out/phpDebug.js" },
}
dap.configurations.php = {
	{
		name = "Listen for Xdebug",
		type = "php",
		request = "launch",
		port = 9003,
	},
	{
		name = "Debug currently open script",
		type = "php",
		request = "launch",
		port = 9003,
		cwd = "${fileDirname}",
		program = "${file}",
		runtimeExecutable = "php",
	},
}

dapvscjs.setup({
	debugger_path = "mason_path .. 'packages/js-debug-adapter'", -- Path to vscode-js-debug installation.
	debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
	adapters = { "pwa-node", "pwa-chrome" }, -- which adapters to register in nvim-dap
})
dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = require'dap.utils'.pick_process,
    cwd = "${workspaceFolder}",
  }
}
dap.configurations.typescript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = require'dap.utils'.pick_process,
    cwd = "${workspaceFolder}",
  }
}
dap.configurations.typescriptreact = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = require'dap.utils'.pick_process,
    cwd = "${workspaceFolder}",
  }
}

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

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
