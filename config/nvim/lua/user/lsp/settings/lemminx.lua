return {
    cmd = {
        os.getenv('HOME') ..  "/bin/lemminx"
        -- vim.env.HOME .. "/bin/lemminx"
    },
    filetypes = { "xml", "xsd", "svg", "xsl", "xslt" },
    root_dir = vim.lsp.util.find_git_ancestor,
    single_file_support = true
}
