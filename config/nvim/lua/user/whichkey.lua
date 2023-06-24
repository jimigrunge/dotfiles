local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local mappings = {
  [";"] = { "<cmd>Alpha<cr>", "Dashboard" },
  ["/"] = { "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", "Comment" },
  ["?"] = { "<cmd>Cheatsheet<cr>", "Cheatsheet" },
  [">"] = { "<cmd>BufferLineMoveNext<cr>", "BufferMoveNext" },
  ["<lt>"] = { "<cmd>BufferLineMovePrev<cr>", "BufferMovePrevious" },
  ["a"] = { "<cmd>Alpha<cr>", "[A]lpha" },
  ["b"] = {
    name = "[B]uffers",
    ["b"] = { "<cmd>Telescope buffers theme=ivy<cr>", "[B]uffers" },
    ["c"] = { "<cmd>Bdelete!<cr>", "[C]lose Buffer" },
    ["p"] = { "<cmd>BufferLinePick<cr>", "[P]ick" },
    ["r"] = { "<cmd>set relativenumber!<cr>", "[R]elative Numbers" },
    ["j"] = { "<cmd>BufferLineMoveNext<cr>", "BufferMoveNext" },
    ["k"] = { "<cmd>BufferLineMovePrev<cr>", "BufferMovePrevious" },
  },
  ["c"] = { "<cmd>Bdelete!<cr>", "[C]lose Buffer" },
  ["d"] = {
    name = "[D]ebug",
    ["b"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle [B]reakpoint" },
    ["B"] = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Conditional [B]reakpoint" },
    ["c"] = { "<cmd>lua require'dap'.continue()<cr>", "[C]ontinue" },
    ["e"] = { "<cmd>lua require'dapui'.eval(<expression>)<cr>", "[E]val Expression" },
    ["i"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step [I]nto" },
    ["l"] = { "<cmd>lua require'dap'.run_last()<cr>", "Run [L]ast" },
    ["o"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step [O]ver" },
    ["O"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step [O]ut" },
    ["r"] = { "<cmd>lua require'dap'.repl.open()<cr>", "[R]EPL" },
    ["t"] = { "<cmd>lua require'dap'.terminate()<cr>", "[T]erminate" },
    ["u"] = { "<cmd>lua require'dapui'.toggle()<cr>", "Dap[U]i Toggle" },
    --[[ b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" }, ]]
    --[[X c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" }, ]]
    --[[ C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" }, ]]
    --[[ d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" }, ]]
    --[[ g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" }, ]]
    --[[X i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" }, ]]
    --[[X o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" }, ]]
    --[[ p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" }, ]]
    --[[ r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" }, ]]
    --[[X s = { "<cmd>lua require'dap'.continue()<cr>", "Start" }, ]]
    --[[X t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" }, ]]
    --[[ q = { "<cmd>lua require'dap'.close()<cr>", "Quit" }, ]]
    --[[X u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" }, ]]
    --[[X U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" }, ]]
  },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "[E]xplorer" },
  ["f"] = { "<cmd>Telescope live_grep<cr>", "[F]ind Text" },
  ["g"] = {
    name = "[G]it",
    ["a"] = { "<cmd>Git blame<cr>", "Bl[a]me" },
    ["b"] = { "<cmd>Telescope git_branches<cr>", "Checkout [b]ranch" },
    ["c"] = { "<cmd>Telescope git_commits<cr>", "Checkout [c]ommit" },
    ["C"] = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for [c]urrent file)" },
    ["d"] = {
      name = "[D]iffView",
      ["c"] = { "<cmd>DiffviewClose<cr>", "Diff View [C]lose" },
      ["d"] = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
      ["f"] = { "<cmd>DiffviewFileHistory<cr>", "[F]ile History" },
      ["o"] = { "<cmd>DiffviewOpen<cr>", "Diff View [O]pen" },
    },
    ["e"] = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", "Toggle Blam[e]" },
    ["g"] = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazy[G]it" },
    ["j"] = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    ["k"] = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    ["l"] = { "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>", "B[l]ame" },
    ["o"] = { "<cmd>Telescope git_status<cr>", "[O]pen changed file" },
    ["p"] = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "[P]review Hunk" },
    -- This works I just don't want it on for the moment
    -- ["r"] = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    -- ["R"] = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    -- ["s"] = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    ["t"] = { "<cmd>Git status<cr>", "S[t]atus"},
    ["u"] = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "[U]ndo Stage Hunk"},
  },
  ["h"] = { "<cmd>nohlsearch<cr>", "[H]ighlight Off" },
  -- ["i"] = {},
  ["j"] = { "<cmd>lua require('trevj').format_at_cursor()<cr>", "Format Structures" },
  -- ["k"] = {},
  ["l"] = {
    name = "[L]SP",
    ["a"] = { "<cmd>CodeActionMenu<cr>", "Code [A]ction" },
    ["c"] = { "<cmd>lua require('neogen').generate()<cr>", "[C]reate DocBlock"},
    ["d"] = { "<cmd>Telescope diagnostics bufnr=0<cr>", "[D]ocument Diagnostics" },
    ["D"] = { "<cmd>lua require('neogen').generate()<cr>", "[D]ocBloc Annotations" },
    ["e"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Line diagnostic [e]rror hover" },
    ["E"] = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Line diagnostic [E]rror" },
    ["f"] = { "<cmd>lua vim.lsp.buf.format()<cr>", "[F]ormat" },
    ["i"] = { "<cmd>LspInfo<cr>", "[I]nfo" },
    ["I"] = { "<cmd>Mason<cr>", "Mason [I]nstaller" },
    ["j"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
    ["k"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
    ["l"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", "Code [L]ens Action" },
    ["M"] = { "<cmd>Mason<cr>", "[M]ason Installer" },
    ["m"] = { "lua require'nvim-treesitter.textobjects.swap'.swap_previous('@parameter.inner')<cr>", "Swap next param" },
    ["n"] = { "lua require'nvim-treesitter.textobjects.swap'.swap_next('@parameter.inner')<cr>", "Swap prev param" },
    ["o"] = { "<cmd>SymbolsOutline<cr>", "Toggle [O]utline" },
    ["q"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "[Q]uickfix" },
    ["r"] = { "<cmd>lua require('cosmic-ui').rename()<cr>", "[R]ename" },
    ["s"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Document [S]ymbols" },
    ["S"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace [S]ymbols" },
    ["t"] = { "lua require'nvim-treesitter.textobjects.lsp_interop'.peek_definition_code('@function.outer')<cr>", "Peek DefCode Func" },
    ["T"] = { "lua require'nvim-treesitter.textobjects.lsp_interop'.peek_definition_code('@class.outer')<cr>", "Peek DefCode Class" },
    ["w"] = { "<cmd>Telescope diagnostics<cr>", "[W]orkspace Diagnostics" },
  },
  ["m"] = {
    name = "[M]arkdown",
    ["p"] = { "<cmd>Glow<cr>", "Markdown [P]review" }
  },
  --[[ ["n"] = {}, ]]
  ["o"] = {
    name = "[O]utline",
    ["t"] = { "<cmd>SymbolsOutline<cr>", "[T]oggle Outline" },
    ["o"] = { "<cmd>SymbolsOutlineOpen<cr>", "[O]pen Outline" },
    ["c"] = { "<cmd>SymbolsOutlineClose<cr>", "[C]lose Outline" }
  },
  ["P"] = { "<cmd>Telescope projects<cr>", "[P]rojects" },
  ["p"] = {
    name = "[P]acker",
    ["c"] = { "<cmd>PackerCompile<cr>", "[C]ompile" },
    ["i"] = { "<cmd>PackerInstall<cr>", "[I]nstall" },
    ["s"] = { "<cmd>PackerSync<cr>", "[S]ync" },
    ["S"] = { "<cmd>PackerStatus<cr>", "[S]tatus" },
    ["u"] = { "<cmd>PackerUpdate<cr>", "[U]pdate" },
  },
  ["q"] = { "<cmd>q!<cr>", "[Q]uit" },
  ["r"] = {
    name = "[R]esume",
    ["s"] = { "<cmd>lua require('persistence').load()<cr>", "[S]ession For Current Directory" },
    ["l"] = { "<cmd>lua require('persistence').load({ last = true })<cr>", "[L]ast Session" },
    ["q"] = { "<cmd>lua require('persistence').stop()<cr>", "[Q]uit Persistence " },
  },
  ["s"] = {
    name = "[S]earch",
    ["/"] = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Current Buffer" },
    ["a"] = { "<cmd>lua require('telescope.builtin').resume()<cr>", "Search [A]gain" },
    ["b"] = { "<cmd>Telescope git_branches<cr>", "Checkout [b]ranch" },
    ["c"] = { "<cmd>lua require('telescope.builtin').colorscheme()<cr>", "[C]olorscheme" },
    ["f"] = { "<cmd>lua require('telescope.builtin').fd()<cr>", "[F]D find file" },
    ["g"] = { "<cmd>lua require 'telescope.builtin'.live_grep()<cr>", "Live [G]rep" },
    ["h"] = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Find [H]elp" },
    ["M"] = { "<cmd>lua require('telescope.builtin').man_pages()<cr>", "[M]an Pages" },
    ["r"] = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Open [R]ecent File" },
    --[[ ["s"] = { ":%s/\\<<C-r><C-w>\\>//gc<Left><Left><Left>", "[S]earch Replace" }, ]]
    ["s"] = { "<cmd>SearchReplaceSingleBufferSelections<cr>", "[S]earch Replace" },
    ["S"] = { "<cmd>SearchReplaceMultiBufferSelections<cr>", "[S]earch Replace Buffers" },
    ["R"] = { "<cmd>lua require('telescope.builtin').registers()<cr>", "Registers" },
    ["k"] = { "<cmd>lua require('telescope.builtin').keymaps()<cr>", "[K]eymaps" },
    ["w"] = { "<cmd>lua require 'telescope.builtin'.grep_string({find_command = { 'rg', vim.fn.expand('<cword>'), '--ignore', '--hidden', '--smart-case' }})<cr>", "Live Grep [W]ord" },
    ["C"] = { "<cmd>lua require('telescope.builtin').commands()<cr>", "[C]ommands" },
    ["p"] = {
      name = "[P]icker",
      ["a"] = { "<cmd>IconPickerInsert alt_font<cr>", "[A]lt Font Picker" },
      ["e"] = { "<cmd>IconPickerInsert emoji<cr>", "[E]moji Picker" },
      ["E"] = { "<cmd>PickEverything alt_font nerd_font symbols emoji<cr>", "[E]verything Picker" },
      ["i"] = { "<cmd>IconPickerInsert nerd_font<cr>", "[I]con Picker" },
      ["s"] = { "<cmd>IconPickerInsert symbols<cr>", "[S]ymbol Picker" },
    }
  },
  ["t"] = {
    name = "[T]erminal",
    ["g"] = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazy[G]it" },
    ["n"] = { "<cmd>lua _NODE_TOGGLE()<cr>", "[N]ode" },
    ["u"] = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCD[U]" },
    ["b"] = { "<cmd>lua _BPYTOP_TOGGLE()<cr>", "[B]PyTop" },
    ["h"] = { "<cmd>lua _HTOP_TOGGLE()<cr>", "[H]top" },
    ["p"] = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "[P]ython" },
    ["t"] = { "<cmd>ToggleTerm size=30<cr>", "[T]oggle Term" },
    --[[ ["f"] = { "<cmd>ToggleTerm direction=float<cr>", "[F]loat" }, ]]
    --[[ ["t"] = { "<cmd>ToggleTerm size=60<cr>", "[T]oggle" }, ]]
    --[[ ["h"] = { "<cmd>ToggleTerm size=80 direction=horizontal<cr>", "[H]orizontal" }, ]]
    --[[ ["v"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "[V]ertical" }, ]]
  },
  -- ["u"] = {},
  -- ["v"] = {},
  ["v"] = {
    name = "[V]S Code Colors",
    ["d"] = { "<cmd>lua require('vscode').change_style('dark')<cr>", "VS Code [D]ark" },
    ["l"] = { "<cmd>lua require('vscode').change_style('light')<cr>", "VS Code [L]ight" },
    ["o"] = { "<cmd>colorscheme onedarker<cr>", "[O]ne Darker" },
    ["p"] = { "<cmd>colorscheme darkplus<cr>", "Dark [P]lus" },
  },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["x"] = {
    name = "Diagnostic[x]",
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "[D]ocument" },
    l = { "<cmd>TroubleToggle loclist<cr>", "[L]oclist" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "[Q]uickfix" },
    R = { "<cmd>TroubleToggle lsp_references<cr>", "[R]eferences" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "[W]orkspace" },
    x = { "<cmd>TroubleToggle<cr>", "Trouble" },
    t = { name = "[T]odo",
      l = { "<cmd>TodoLocList<cr>", "[L]ocal List" },
      q = { "<cmd>TodoQuickFix<cr>", "[Q]uickFix" },
      t = { "<cmd>TodoTelescope<cr>", "[T]elescope" },
      x = { "<cmd>TodoTrouble<cr>", "Trouble" },
    },
  },
  -- ["y"] = {},
  -- ["z"] = {},
}

local n_mappings = {
  ["g"] = {
    name = "LSP",
    ["b"] = { name="+Comment blockwise" },
    ["c"] = { name="+Comment linewise" },
    ["d"] = { "<cmd>Telescope lsp_definitions<cr>", "Definition" },
    ["D"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
    ["i"] = { "<cmd>Telescope lsp_implementations<cr>", "Implementation" },
    ["l"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Open Float"},
    ["o"] = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
    ["r"] = { "<cmd>Telescope lsp_references<cr>", "References" },
    ["R"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    ["v"] = { name="Reselect" }
  },
  ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
  ["<C-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature" }
}

local v_mappings = {
  ["/"] = { "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", "Comment" },
  ["f"] = { ":s/\\v%V//gc<Left><Left><Left><Left>", "Search Replace Visual" },
}

local i_mappings = {
  --[[ ["a"] = { "<cmd>IconPickerInsert alt_font<cr>", "Alt Font Picker" }, ]]
  --[[ ["e"] = { "<cmd>IconPickerInsert emoji<cr>", "Emoji Picker" }, ]]
  --[[ ["E"] = { "<cmd>PickEverything alt_font nerd_font symbols emoji<cr>", "Everything Picker" }, ]]
  --[[ ["i"] = { "<cmd>IconPickerInsert nerd_font<cr>", "Icon Picker" }, ]]
  --[[ ["s"] = { "<cmd>IconPickerInsert symbols<cr>", "Symbol Picker" }, ]]
}

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    ["<space>"] = "SPC",
    ["<cr>"] = "RET",
    ["<tab>"] = "TAB",
    ["<leader>"] = "LDR",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
  -- disable the WhichKey popup for certain buf types and file types.
  -- Disabled by deafult for Telescope
  --[[ disable = { ]]
  --[[   buftypes = {}, ]]
  --[[   filetypes = { "TelescopePrompt" }, ]]
  --[[ }, ]]
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local iopts = {
  mode = "i", -- VISUAL mode
  prefix = "<C-i>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(n_mappings, { mode = "n", prefix = "", preset = true })
which_key.register(v_mappings, vopts)
which_key.register(i_mappings, iopts)
