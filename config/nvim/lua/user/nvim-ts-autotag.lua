-- Automatically close and rename HTML tags.
local M = {
  "windwp/nvim-ts-autotag",
  commit = "8515e48a277a2f4947d91004d9aa92c29fdc5e18",
}

function M.config()
  local status_ok, tsautotag = pcall(require, "nvim-ts-autotag")
  if not status_ok then
    print "TS Autotag not loaded"
    return
  end

  tsautotag.setup {
    filetypes = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "javascript.jsx",
      "typescript.tsx",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "rescript",
      "xml",
      "xsl",
      "php",
      "markdown",
      "astro",
      "glimer",
      "handlebars",
      "hbs",
      "blade",
      "twig",
    },
    skip_tags = {
      "area",
      "base",
      "br",
      "col",
      "command",
      "embed",
      "hr",
      "img",
      "slot",
      "input",
      "keygen",
      "link",
      "meta",
      "param",
      "source",
      "track",
      "wbr",
      "menuitem"
    }
  }
end

return M
