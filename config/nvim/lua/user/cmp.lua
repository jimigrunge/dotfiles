local M = {
  "hrsh7th/nvim-cmp",
  commit = "538e37ba87284942c1d76ed38dd497e54e65b891",
  dependencies = {
    {
      "hrsh7th/cmp-buffer",
      commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
    },
    {
      "hrsh7th/cmp-path",
      commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
    },
    {
      "hrsh7th/cmp-cmdline",
      commit = "8ee981b4a91f536f52add291594e89fb6645e451",
    },
    {
      "saadparwaiz1/cmp_luasnip",
      commit = "05a9ab28b53f71d1aece421ef32fee2cb857a843",
    },
    {
      "hrsh7th/cmp-nvim-lsp",
      commit = "5af77f54de1b16c34b23cba810150689a3a90312",
    },
    {
      "hrsh7th/cmp-nvim-lua",
      commit = "f12408bdb54c39c23e67cab726264c10db33ada8",
    },
    {
      "SergioRibera/cmp-dotenv",
      commit = "fd78929551010bc20602e7e663e42a5e14d76c96",
    },
    -- Snippets
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp",
      version = "v2.2.*",
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          commit = "69a2c1675b66e002799f5eef803b87a12f593049",
        }
      }
    }
  }
}

function M.config()
  local cmp_status_ok, cmp = pcall(require, "cmp")
  if not cmp_status_ok then
    print("cmp not loaded")
    return
  end

  local icons = require "user.icons"
  local kind_icons = icons.kind

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
  luasnip.filetype_extend("html", { "twig" })
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

  vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local has_words_before_copilot = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
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
        if cmp.visible() and has_words_before_copilot() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        elseif cmp.visible() then
          cmp.select_next_item()
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
          buffer = "[Buffer]",
          copilot = "[Copilot]",
          dotenv = "[DotEnv]",
          luasnip = "[Snippet]",
          npm = "[Npm]",
          nvim_lsp = "[Lsp]",
          nvim_lua = "[Lua]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end,
      expandable_indicator = true,
    },
    sources = {
      { name = "luasnip",  group_index = 1, priority = 1000 },
      {
        name = "nvim_lsp",
        group_index = 1,
        priority = 900,
        entry_filter = function(entry, _)
          local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
          if kind == "Text" then
            return false
          end
          return true
        end,
      },
      { name = "buffer",   group_index = 1, priority = 800 },
      { name = "copilot",  group_index = 1, priority = 700 },
      { name = "path",     group_index = 1, priority = 500 },
      { name = "dotenv",   group_index = 1, priority = 400 },
      { name = "nvim_lua", group_index = 1, priority = 300 },
      {
        name = 'npm',
        group_index = 1,
        priority = 200,
      },
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
        cmp.config.compare.exact,
        copilot_cmp_comparators.prioritize,
        -- Below is the default comparitor list and order for nvim-cmp
        cmp.config.compare.offset,
        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    -- completion = {
    --   autocomplete = false
    -- }
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
      {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!' }
        }
      }
    })
  })
end

return M
