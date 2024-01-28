local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  print("cmp not loaded")
  return
end

local cc_comparators_status_ok, copilot_cmp_comparators = pcall(require, "copilot_cmp.comparators")
if not cc_comparators_status_ok then
  print("copilot_cmp_comparators not loaded")
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  print("LuaSnip not loaded")
  return
end
require("luasnip/loaders/from_vscode").lazy_load()
luasnip.filetype_extend("c", { "cdoc" })
luasnip.filetype_extend("cpp", { "cppdoc" })
luasnip.filetype_extend("cs", { "csharpdoc" })
luasnip.filetype_extend("html", { "blade" })
luasnip.filetype_extend("java", { "javadoc" })
luasnip.filetype_extend("javascript", { "jsdoc" })
luasnip.filetype_extend("kotlin", { "kdoc" })
luasnip.filetype_extend("lua", { "luadoc" })
luasnip.filetype_extend("php", { "phpdoc", "blade" })
luasnip.filetype_extend("python", { "pydoc" })
luasnip.filetype_extend("ruby", { "rdoc" })
luasnip.filetype_extend("rust", { "rustdoc" })
luasnip.filetype_extend("sh", { "shelldoc" })
luasnip.filetype_extend("typescript", { "javascript", "tsdoc" })

local icons = require "user.icons"
local kind_icons = icons.kind
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end


cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    --[[ ["<C-k>"] = cmp.mapping.select_prev_item(), ]]
    --[[ ["<C-j>"] = cmp.mapping.select_next_item(), ]]
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if has_words_before() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          cmp.select_next_item()
        end
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- This concatonates the icons with the name of the item kind
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        luasnip = "[Snippet]",
        npm = "[Npm]",
        nvim_lua = "[Lua]",
        copilot = "[Copilot]",
        nvim_lsp = "[Lsp]",
        buffer = "[Buffer]",
        path = "[Path]",
        dotenv = "[DotEnv]",
      })[entry.source.name]
      return vim_item
    end,
    expandable_indicator = true,
  },
  sources = {
    { name = "luasnip",  group_index = 1 },
    {
      name = 'npm',
      group_index = 1,
      keyword_length = 3,
    },
    { name = "nvim_lua", group_index = 1 },
    { name = "dotenv",   group_index = 1 },
    {
      name = "copilot",
      group_index = 1,
      priority = 7,
    },
    {
      name = "nvim_lsp",
      group_index = 1,
      priority = 8,
      entry_filter = function(entry, _)
        local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
        if kind == "Text" then
          return false
        end
        return true
      end,
    },
    { name = "buffer",   group_index = 1 },
    { name = "path",     group_index = 1 },
  },
  confirm_opts = {
    -- behavior = cmp.ConfirmBehavior.Replace,
    behavior = cmp.ConfirmBehavior.Select,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      copilot_cmp_comparators.prioritize,
      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})

-- Auto complete search based on buffer
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Auto complete command line
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
