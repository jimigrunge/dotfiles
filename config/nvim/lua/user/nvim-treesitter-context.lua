local M = {
  "nvim-treesitter/nvim-treesitter-context",
  commit = "23b699ac40091d8c729f024b3f1400bc7e26e0c5",
  -- commit = "e75357fa49ddcdeaf9ba1e60f4582398fed3266b",
}

function M.config()
  local status_ok, treesitter_context = pcall(require, "treesitter-context")
  if not status_ok then
    print 'treesitter_context not loaded'
    return
  end

  treesitter_context.setup {
    enable = true,          -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0,          -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0,  -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer',   -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    patterns = {            -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
      -- For all filetypes
      -- Note that setting an entry here replaces all other patterns for this entry.
      -- By setting the 'default' entry below, you can control which nodes you want to
      -- appear in the context window.
      default = {
        'class',
        'function',
        'method',
        -- 'for', -- These won't appear in the context
        -- 'while',
        -- 'if',
        -- 'switch',
        -- 'case',
      },
      -- Example for a specific filetype.
      -- If a pattern is missing, *open a PR* so everyone can benefit.
      --   rust = {
      --       'impl_item',
      --   },
    },
    exact_patterns = {
      -- Example for a specific filetype with Lua patterns
      -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
      -- exactly match "impl_item" only)
      -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20,     -- The Z-index of the context window
    mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
    separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
  }
end

return M
