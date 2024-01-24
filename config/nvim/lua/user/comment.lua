local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  print 'Comment not loaded'
  return
end

comment.setup {
  padding = true,
  sticky = true,
  ignore = nil,
  toggler = {
    line = 'gcc',
    block = 'gbc',
  },
  opleader = {
    line = 'gc',
    block = 'gb',
  },
  extra = {
    above = 'gcO',
    below = 'gco',
    eol = 'gcA',
  },
  mappings = {
    basic = true,
    extra = true,
  },
  post_hook = nil,
  -- Custom config
  pre_hook = function(ctx)
    local U = require "Comment.utils"
    local type = (ctx.ctype == U.ctype.linewise) and "__default" or "__multiline"
    local location = nil

    if ctx.ctype == U.ctype.blockwise then
      location = require("ts_context_commentstring.utils").get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require("ts_context_commentstring.utils").get_visual_start_location()
    end

    return require("ts_context_commentstring.internal").calculate_commentstring {
      key = type,
      location = location,
    }
  end,
}

require('ts_context_commentstring').setup {
  enable_autocmd = false,
  -- Keybindings to use for the commentary.nvim integration
  commentary_integration = {
    Commentary = 'gc',
    CommentaryLine = 'gcc',
    ChangeCommentary = 'cgc',
    CommentaryUndo = 'gcu',
  },
  config = {},
  languages = {
    -- Languages that have a single comment style
    astro = '<!-- %s -->',
    c = { __default = '// %s', __multiline = '/* %s */' },
    css = '/* %s */',
    glimmer = '{{! %s }}',
    go = { __default = '// %s', __multiline = '/* %s */' },
    graphql = '# %s',
    haskell = '-- %s',
    handlebars = '{{! %s }}',
    html = '<!-- %s -->',
    lua = { __default = '-- %s', __multiline = '--[[ %s ]]' },
    nix = { __default = '# %s', __multiline = '/* %s */' },
    php = { __default = '// %s', __multiline = '/* %s */' },
    python = { __default = '# %s', __multiline = '""" %s """' },
    rescript = { __default = '// %s', __multiline = '/* %s */' },
    scss = { __default = '// %s', __multiline = '/* %s */' },
    sh = '# %s',
    bash = '# %s',
    solidity = { __default = '// %s', __multiline = '/* %s */' },
    sql = '-- %s',
    svelte = '<!-- %s -->',
    twig = '{# %s #}',
    typescript = { __default = '// %s', __multiline = '/* %s */' },
    vim = '" %s',
    vue = '<!-- %s -->',
    zsh = '# %s',

    -- Languages that can have multiple types of comments
    tsx = {
      __default = '// %s',
      __multiline = '/* %s */',
      jsx_element = '{/* %s */}',
      jsx_fragment = '{/* %s */}',
      jsx_attribute = { __default = '// %s', __multiline = '/* %s */' },
      comment = { __default = '// %s', __multiline = '/* %s */' },
      call_expression = { __default = '// %s', __multiline = '/* %s */' },
      statement_block = { __default = '// %s', __multiline = '/* %s */' },
      spread_element = { __default = '// %s', __multiline = '/* %s */' },
    },
  },
}
