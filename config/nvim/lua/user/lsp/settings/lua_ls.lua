-- Configure lua language server for neovim development
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  log_level = 2,
  root_dir = require("lspconfig").util.root_pattern(
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git"
  ),
  single_file_support = true,
  Lua = {
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { "vim" },
    },
    runtime = {
      -- LuaJIT in the case of Neovim
      version = "LuaJIT",
      path = runtime_path,
    },
    workspace = {
      checkThirdParty = false,
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.stdpath("config") .. "/lua"] = true,
      },
    },
    telemetry = {
      enable = false,
    },
  },
}
