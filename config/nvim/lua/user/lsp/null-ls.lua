local none_ls_status_ok, none_ls = pcall(require, "null-ls")
if not none_ls_status_ok then
  print('none_ls not loaded')
  return
end

local formatting = none_ls.builtins.formatting
local diagnostics = none_ls.builtins.diagnostics

none_ls.setup({
  debug = false,
  sources = {
    -- -----------------
    -- Formatting
    -- -----------------
    --- js/jsx/ts/tsx/json
    formatting.prettier,
    --- python
    formatting.black.with({ extra_args = { "--fast" } }),
    --- lua
    formatting.stylua.with({
      extra_args = {
        "--config-path",
        vim.fn.expand(vim.fn.stdpath("config") .. "/.stylua.toml"),
      }
    }),
    --- cpp
    formatting.clang_format,
    --- bash
    formatting.shellharden,
    --- java
    formatting.google_java_format,
    --- markdown
    formatting.textlint,
    -- -----------------
    -- Linting
    -- -----------------
    --- js/jsx/ts/tsx/json
    diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js")
      end,
    }),
    --- python
    --[[ diagnostics.flake8, ]]
    --- cpp
    diagnostics.cpplint,
    --- css
    diagnostics.stylelint,
    --- bash
    diagnostics.shellcheck,
    --- markdown
    diagnostics.markdownlint_cli2,
    -- -----------------
    -- Spelling
    -- -----------------
    none_ls.builtins.hover.dictionary,
    none_ls.builtins.completion.spell,
    -- -----------------
    -- Git actions
    -- -----------------
    none_ls.builtins.code_actions.gitsigns,
  },
})
