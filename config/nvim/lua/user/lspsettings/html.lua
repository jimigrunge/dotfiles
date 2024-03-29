return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "blade", "twig" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
    provideFormatter = true
  },
  settings = {
    rootMarkers = { ".git/", "package.json", "composer.json", "cargo.lock" },
  },
  single_file_support = true
}
