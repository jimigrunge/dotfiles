-- Find, Filter, Preview, Pick.
local M = {
  "nvim-telescope/telescope.nvim",
  branch = '0.1.x',
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = 'make',
      lazy = true,
      commit = "dae2eac9d91464448b584c7949a31df8faefec56",
      -- commit = "6c921ca12321edaa773e324ef64ea301a1d0da62",
    },
    {
      "nvim-telescope/telescope-media-files.nvim",
      commit = "0826c7a730bc4d36068f7c85cf4c5b3fd9fb570a",
    },
  },
}

function M.config()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    print 'Telescope not loaded'
    return
  end

  local wk = require "which-key"
  wk.add ({
    {"<leader>bb", "<cmd>Telescope buffers<cr>", desc="[B]uffers Telescope" },
    {"<leader>f" , "<cmd>Telescope live_grep<cr>", desc="[F]ind Text" },
    {"<leader>gb", "<cmd>Telescope git_branches<cr>", desc="Checkout [b]ranch" },
    {"<leader>go", "<cmd>Telescope git_status<cr>", desc="[O]pen changed file" },
    {"<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", desc="[D]ocument Diagnostics" },
    {"<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc="Document [S]ymbols" },
    {"<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc="Workspace [S]ymbols" },
    {"<leader>lw", "<cmd>Telescope diagnostics<cr>", desc="[W]orkspace Diagnostics" },
    {"<leader>P" , "<cmd>Telescope projects<cr>", desc="[P]rojects" },
    {"<leader>s/", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", desc="Current Buffer" },
    {"<leader>sa", "<cmd>lua require('telescope.builtin').resume()<cr>", desc="Search [A]gain" },
    {"<leader>sb", "<cmd>Telescope git_branches<cr>", desc="Checkout [b]ranch" },
    {"<leader>sc", "<cmd>lua require('telescope.builtin').colorscheme()<cr>", desc="[C]olorscheme" },
    {"<leader>sf", "<cmd>lua require('telescope.builtin').fd()<cr>", desc="[F]D find file" },
    {"<leader>sg", "<cmd>lua require 'telescope.builtin'.live_grep()<cr>", desc="Live [G]rep" },
    {"<leader>sh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", desc="Find [H]elp" },
    {"<leader>sM", "<cmd>lua require('telescope.builtin').man_pages()<cr>", desc="[M]an Pages" },
    {"<leader>sr", "<cmd>lua require('telescope.builtin').oldfiles()<cr>", desc="Open [R]ecent File" },
    {"<leader>sR", "<cmd>lua require('telescope.builtin').registers()<cr>", desc="Registers" },
    {"<leader>sk", "<cmd>lua require('telescope.builtin').keymaps()<cr>", desc="[K]eymaps" },
    {
      "<leader>sw", "<cmd>lua require 'telescope.builtin'.grep_string({find_command = { 'rg', vim.fn.expand('<cword>'), '--ignore', '--hidden', '--smart-case' }})<cr>",
      desc="Live Grep [W]ord"
    },
    {"<leader>sC", "<cmd>lua require('telescope.builtin').commands()<cr>", desc="[C]ommands" },
  }, opts)
  wk.add({
    {"ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc="[F]iles" },
    {"gd", "<cmd>Telescope lsp_definitions<cr>", desc="Definition" },
    {"gi", "<cmd>Telescope lsp_implementations<cr>", desc="Implementation" },
    {"gr", "<cmd>Telescope lsp_references<cr>", desc="References" },

  }, nopts)

  -- -----------------------------------------------------------
  -- Reformat serch result to show filenames first
  -- https://github.com/nvim-telescope/telescope.nvim/issues/2014
  local function filenameFirst(_, path)
    local tail = vim.fs.basename(path)
    local parent = vim.fs.dirname(path)
    if parent == "." then return tail end
    return string.format("%s\t\t%s\t\t", tail, parent)
  end

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "TelescopeResults",
    callback = function(ctx)
      vim.api.nvim_buf_call(ctx.buf, function()
        vim.fn.matchadd("TelescopeParent", "\t\t.*$")
        vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
      end)
    end,
  })
  -- -----------------------------------------------------------

  telescope.load_extension('media_files')
  -- telescope.load_extension('cmdline')

  local actions = require "telescope.actions"
  local icons = require "user.icons"

  telescope.setup {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.99,
        height = 0.89
      },
      prompt_prefix = icons.ui.Telescope,
      selection_caret = icons.ui.Forward,
      path_display = { "smart" },
      file_ignore_patterns = { ".git/", "node_modules" },

      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-c>"] = actions.close,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,

          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.complete_tag,
          ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        },

        n = {
          ["<esc>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["?"] = actions.which_key,
        },
      },
    },
    pickers = {
      git_status = {
        path_display = filenameFirst,
        hidden = true,
      },
      find_files = {
        path_display = filenameFirst,
        hidden = true,
      },
      buffers = {
        path_display = filenameFirst,
        ignore_current_buffer = true,
        sort_lastused = true,
      },
      fd = {
        path_display = filenameFirst,
        hidden = true,
      },
      oldfiles = {
        path_display = filenameFirst,
        hidden = true,
      },
      grep_string = {
        path_display = filenameFirst,
        hidden = true,
      },
      live_grep = {
        path_display = filenameFirst,
        hidden = true,
      },
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      -- please take a look at the readme of the extension you want to configure
      media_files = {
        -- filetypes whitelist
        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
        filetypes = { "png", "jpg", "mp4", "webm", "pdf", "webp", "jpeg" },
        find_cmd = "rg" -- find command (defaults to `fd`)
      }
    },
  }
end

return M
