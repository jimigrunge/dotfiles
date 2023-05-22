local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    -- -----------------
    -- Formatting
    -- -----------------
    -- js/jsx/ts/tsx/json
    formatting.prettier,
    -- python
    formatting.black.with({ extra_args = { "--fast" } }),
    -- lua
    formatting.stylua,
    -- cpp
    formatting.clang_format,
    -- php
    --[[ formatting.phpcbf.with({ extra_args = { "--standard=PSR12", "-"}}), ]]
    --bash
    formatting.shellharden,
    -- java
    formatting.google_java_format,
    -- -----------------
    -- Linting
    -- -----------------
    -- js/jsx/ts/tsx/json
    diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js")
      end,
    }),
    -- python
    -- diagnostics.flake8,
    -- lua - This is disabled in favor of the LSP linter
    --       due to unrecognized global variable bug
    -- diagnostics.luacheck,
    -- php
    --[[ diagnostics.phpcs.with({extra_args = { "--standard=PSR12", "-"}}), ]]
    -- cpp
    diagnostics.cpplint,
    -- css
    diagnostics.stylelint,
    -- bash
    diagnostics.shellcheck,
    -- -----------------
    -- Spelling
    -- -----------------
    null_ls.builtins.hover.dictionary,
    null_ls.builtins.completion.spell,
    -- -----------------
    -- Git actions
    -- -----------------
    null_ls.builtins.code_actions.gitsigns,
  },
})
