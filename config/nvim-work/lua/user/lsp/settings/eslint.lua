return {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    -- "typescript",
    -- "typescriptreact",
    -- "typescript.tsx",
    "vue",
  },
  -- handlers = {
  --   ["eslint/confirmESLintExecution"] = <function 1>,
  --   ["eslint/noLibrary"] = <function 2>,
  --   ["eslint/openDoc"] = <function 3>,
  --   ["eslint/probeFailed"] = <function 4>
  -- },
  on_new_config = function(config, new_root_dir)
    -- The "workspaceFolder" is a VSCode concept. It limits how far the
    -- server will traverse the file system when locating the ESLint config
    -- file (e.g., .eslintrc).
    config.settings.workspaceFolder = {
      uri = new_root_dir,
      name = vim.fn.fnamemodify(new_root_dir, ":t"),
    }
  end,
  --[[ root_dir = vim.lsp.util.find_git_ancestor, ]]
  root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  single_file_support = true,
  settings = {
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine",
      },
      showDocumentation = {
        enable = true,
      },
    },
    codeActionOnSave = {
      enable = false,
      mode = "all",
    },
    format = true,
    nodePath = "",
    onIgnoredFiles = "off",
    packageManager = "npm",
    quiet = false,
    rulesCustomizations = {},
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = {
      mode = "location",
    },
  },
}
