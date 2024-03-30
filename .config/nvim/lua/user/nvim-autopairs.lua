-- Insert and delete brackets, parens, quotes in pair.
local M = {
  "windwp/nvim-autopairs",
  commit = "9fd41181693dd4106b3e414a822bb6569924de81",
}

function M.config()
  local status_ok, npairs = pcall(require, "nvim-autopairs")
  if not status_ok then
    print "Nvim Autopairs not loaded"
    return
  end
  local Rule = require 'nvim-autopairs.rule'
  local cond = require 'nvim-autopairs.conds'

  npairs.setup {
    check_ts = true,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      java = false,
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
    fast_wrap = {
      map = "<M-e>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      offset = 0, -- Offset from pattern match
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "PmenuSel",
      highlight_grey = "LineNr",
    },
  }

  npairs.add_rules {
    -- Arrow functions - TODO: this is not working
    Rule('%(.*%)%s*%=>$', ' {  }', { 'typescript', 'typescriptreact', 'javascript', 'javescriptreact', 'tsx', 'jsx' })
        :use_regex(true)
        :set_end_pair_length(2),
    -- Add space around =, ==, === signs
    -- Rule('=', '')
    --     :with_pair(cond.not_inside_quote())
    --     :with_pair(function(opts)
    --       local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
    --       if last_char:match('[%w%=%s]') then
    --         return true
    --       end
    --       return false
    --     end)
    --     :replace_endpair(function(opts)
    --       local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
    --       local next_char = opts.line:sub(opts.col, opts.col)
    --       next_char = next_char == ' ' and '' or ' '
    --       if prev_2char:match('%w$') then
    --         return '<bs> =' .. next_char
    --       end
    --       if prev_2char:match('%=$') then
    --         return next_char
    --       end
    --       if prev_2char:match('=') then
    --         return '<bs><bs>=' .. next_char
    --       end
    --       return ''
    --     end)
    --     :set_end_pair_length(0)
    --     :with_move(cond.none())
    --     :with_del(cond.none())
  }

  function rule_templates(a1, ins, a2, lang)
    npairs.add_rule(
      Rule(ins, ins, lang)
      :with_pair(function(opts) return a1 .. a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1) end)
      :with_move(cond.none())
      :with_cr(cond.none())
      :with_del(function(opts)
        local col = vim.api.nvim_win_get_cursor(0)[2]
        return a1 .. ins .. ins .. a2 ==
        opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2)                            -- insert only works for #ins == 1 anyway
      end)
    )
  end

  -- Twig/Symfony autocomplete
  rule_templates('{', '%', '}', 'twig')
  rule_templates('{%', ' ', '%}', 'twig')
  rule_templates('{', '#', '}', 'twig')
  rule_templates('{#', ' ', '#}', 'twig')
  -- Blade/Laravel autocomplere - TODO: Why is blade config not working?
  rule_templates('{', '--', '}', 'blade')
  rule_templates('{--', ' ', '--}', 'blade')
  -- Space between parens
  -- rule_templates('(', ' ', ')')

  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  local cmp_status_ok, cmp = pcall(require, "cmp")
  if not cmp_status_ok then
    return
  end
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
end

return M
