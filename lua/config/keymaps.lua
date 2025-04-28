-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center cursor after moving down half-page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center cursor after moving up half-page" })
vim.keymap.set("n", "<c-a-n>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<c-a-p>", "<Plug>(YankyCycleBackward)")
if not vim.g.vscode then
  vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
end
vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")
vim.keymap.set("n", "<Leader>n", "<Cmd> Neorg <CR>", { desc = "Neorg" })

-- Delete default LazyVim keymaps
vim.keymap.del("n", "<leader>L")
vim.keymap.del("n", "<leader>l")

local opts = {
  mode = "n",     -- NORMAL mode
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}
local mappings = {
  -- Better window movement
  ["<C-h>"] = { "<C-w>h", "Window move Left" },
  ["<C-j>"] = { "<C-w>j", "Window move Down" },
  ["<C-k>"] = { "<C-w>k", "Window move Up" },
  ["<C-l>"] = { "<C-w>l", "Window move Right" },

  -- Resize with arrows
  ["<C-Up>"] = { ":resize -2<CR>", "Window resize Horizontal Decrease " },
  ["<C-Down>"] = { ":resize +2<CR>", "Window resize Horizontal Increase" },
  ["<C-Left>"] = { ":vertical resize -2<CR>", "Window resize Vertical Decrease" },
  ["<C-Right>"] = { ":vertical resize +2<CR>", "Window resize Vertical Increase" },

  -- Move current line / block with Alt-j/k a la vscode.
  ["<A-j>"] = { ":m .+1<CR>==", "Move current line/block Up" },
  ["<A-k>"] = { ":m .-2<CR>==", "Move current line/block Down" },

  -- QuickFix
  ["]q"] = { ":cnext<CR>", "QuickFix Next" },
  ["[q"] = { ":cprev<CR>", "QuickFix Prev" },
  ["<C-q>"] = { ":call QuickFixToggle()<CR>", "QuickFix Toggle" },

  -- save
  ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

  -- Copy all
  ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

  -- cycle through buffers
  ["<tab>"] = { "<cmd> BufferLineCycleNext <CR>", "Goto next buffer" },

  ["<S-tab>"] = { "<cmd> BufferLineCyclePrev <CR>", "Goto prev buffer" },

  -- Add descriptions for empty shortcuts
  ["p"] = { "p", "Paste" },
  ["P"] = { "P", "Paste" },

  -- nvim-treesitter-context shortcuts
  ["[c"] = { function()
    require("treesitter-context").go_to_context()
  end, "Goto treesitter context" },

  -- duplicate line without touching " register
  ["yyp"] = { ":co.<CR>", "Duplicate line" },

  -- nvim-treesitter-context shortcuts
  ["gvd"] = { function()
    local current_full_path = vim.api.nvim_buf_get_name(0)
    local current_cursor_pos = vim.api.nvim_win_get_cursor(0)

    local original_window = vim.api.nvim_get_current_win()
    local buffer_name
    repeat
      vim.cmd(vim.api.nvim_replace_termcodes('normal <C-l>', true, true, true))
      local current_buf = vim.api.nvim_get_current_buf()
      buffer_name = vim.api.nvim_buf_get_name(current_buf)
    until (not string.find(buffer_name, 'NvimTree')) or vim.api.nvim_get_current_win() == original_window

    vim.cmd("e " .. current_full_path)
    vim.api.nvim_win_set_cursor(0, current_cursor_pos)

    vim.lsp.buf.definition()
  end, "Goto Definition in next window" },

}

local leader_mappings_opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

local leader_mappings = {
  -- Set line number
  n = {
    name = "LineNumbers",
    ["r"] = { ":set relativenumber!<CR>", "Toggle relative number" },
    ["n"] = { ":set number!<CR>", "Toggle number" },
  },

  -- Search submenu
  s = {
    ["F"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current [F]ile" },
    ["L"] = { "<cmd>Telescope resume<cr>", "Resume last search" },
    ["l"] = {
      function()
        require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
      end,
      "[l]ive grep word under cursor" },

  },

  b = {
    name = "+Buffer",
    ["N"] = { ":enew<CR>", "New buffer" },
    ["c"] = { ":let @+=expand('%:p')<CR>", "[c]opy absolute path to clipboard" },
    f = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
    h = { "<cmd>BufferLineCloseLeft<cr>", "Delete Buffers to the Left" },
    l = {
      "<cmd>BufferLineCloseRight<cr>",
      "Delete Buffers to the Right",
    },
    r = {},
  },

  -- Debug keymaps
  d = {
    ['c'] = {
      function()
        local pattern = vim.fn.getcwd() .. '/.vscode/launch.json'
        local type_to_filetypes = { cppdbg = { "c", "cpp" }, codelldb = { "rust" }, delve = { "go" } }
        vim.print("load_launchjs pattern" .. pattern)
        require('dap.ext.vscode').load_launchjs(pattern, type_to_filetypes)
      end,
      "Reload '.vscode/launch.json'" },
    ['l'] = { "<cmd>lua require('dap').run_last()<CR>", "Run last session" },
    b = {
      name = "Breakpoints",
      ['l'] = { "<cmd>lua require('dap').list_breakpoints()<CR>", "List Breakpoints" },
      ['c'] = { "<cmd>lua require('dap').clear_breakpoints()<CR>", "Clear Breakpoints" },
    }
  },

  -- LSP keymaps
  l = {
    name = "+LSP",
    -- Diagnostic related keymaps
    ['<M-d>'] = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
    ['d'] = { "<cmd>lua vim.diagnostic.open_float({scope=\"line\"})<CR>", "LSP: Show [d]iagnostic in floating window" },

    ['D'] = { "<cmd>Telescope lsp_document_symbols<CR>", "LSP: Document Symbols" },
    ['R'] = {
      function()
        require('custom.config.lsp.rename')({}, {})
      end, "LSP: Custom [R]ename" },
    ['r'] = {
      function()
        require("telescope.builtin").lsp_references({ fname_width = 65, trim_text = true, })
      end,
      "LSP: All [r]eferences" },
    ['H'] = {
      function()
        -- show inlay hints for current buffer
        require('custom.config.lsp').show_inlay_hints(0)
      end,
      "LSP: Show inlay [H]ints" },
    ['s'] = {
      name = "LspSaga",
      ['O'] = { "<cmd>Lspsaga outgoing_calls<CR>", "LspSaga: [O]utgoing Calls" },
      ['i'] = { "<cmd>Lspsaga incoming_calls<CR>", "LspSaga: [i]ncoming Calls" },
      ['a'] = { "<cmd>Lspsaga code_action<CR>", "LspSaga: Code [a]ction" },
      ['d'] = { "<cmd>Lspsaga peek_definition<CR>", "LspSaga: Peek [d]efinition" },
      ['t'] = { "<cmd>Lspsaga peek_type_definition<CR>", "LspSaga: Peek [t]ype Definition" },
      ['D'] = { "<cmd>Lspsaga diangostic_jump_next<CR>", "LspSaga: [D]iagnostic Jump Next" },
      ['f'] = { "<cmd>Lspsaga finder<CR>", "LspSaga: [f]inder" },
      ['K'] = { "<cmd>Lspsaga hover_doc<CR>", "LspSaga: Documentation Hover" },
      ['I'] = { "<cmd>Lspsaga finder imp<CR>", "LspSaga: Finder [I]mplement" },
      ['o'] = { "<cmd>Lspsaga outline<CR>", "LspSaga: Finder [o]utline" },
      ['r'] = { "<cmd>Lspsaga rename<CR>", "LspSaga: [r]ename" },
    },
    ['W'] = { "<cmd>ClangdSwitchSourceHeader<CR>", "LSP: S[W]itch header/source" },
    o = {
      name = "OriginalLSP",
      ["r"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "LSP: [o]riginal [r]efactor" },
    },
    -- Migrate from LunarVim
    f = { "<cmd>lua require('lvim.lsp.utils').format()<cr>", "Format" },

  },

  -- Lazy
  ["L"] = { "<cmd>Lazy<CR>", "Lazy" },

  -- F5: Delete trailing spaces
  ["<F5>"] = { "<cmd>:let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>", "Delete all trailing spaces" },

  -- Wrapping submenu
  W = {
    name = "+Wrapping",
    ['t'] = { "<cmd>ToggleWrapMode<CR>", "Wrapping: [t]oggle Wrap" },
    ['s'] = { "<cmd>SoftWrapMode<CR>", "Wrapping: [s]oft Wrap" },
    ['h'] = { "<cmd>HardWrapMode<CR>", "Wrapping: [h]ard Wrap" },
  },

  -- Split window
  ['|'] = { "<cmd>:vsplit<CR>", "Split window vertically" },

  -- Git keymaps
  g = {
    name = "+Git",
    d = {
      "<cmd>DiffviewOpen<CR>",
      "Git diffview open",
    },
    q = {
      "<cmd>DiffviewClose<CR>",
      "Git diffview close",
    },
    D = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Git Diff",
    },
  },

  -- Comment
  ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },

  -- Close buffer and +code submenu
  ["c"] = { "<cmd>BufferKill<CR>", "Close Buffer, +code" },
}

if not vim.g.vscode then
  local which_key = require "which-key"
  which_key.register(mappings, opts)
  which_key.register(leader_mappings, leader_mappings_opts)
end

-- Add smart semicolon ';' keymap (<C-S-;>) in insert mode
vim.api.nvim_set_keymap('i', '<M-j>', '<Esc><Esc>A;<ESC>a', { noremap = true, silent = true, desc = 'Smart semicolon' })
vim.api.nvim_set_keymap('i', '<C-M-j>', '<Esc><Esc>A;<Cr>',
  { noremap = true, silent = true, desc = 'Smart semicolon with Enter' })

-- Add LSP format in visual mode
vim.api.nvim_set_keymap('v', '<space>lf', "<cmd>lua vim.lsp.buf.format()<CR>",
  { noremap = true, silent = true, desc = 'Format selection' })

-- Add keymap for Googles Translate
vim.api.nvim_set_keymap('v', '<space><C-t>', '', {
  noremap = true,
  callback = function()
    vim.cmd('Translate en')
    -- local keys = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
    -- vim.api.nvim_feedkeys(keys, 'm', false)
    -- vim.api.nvim_feedkeys('<CR>', 'm', false)
    vim.defer_fn(function()
      local keys = vim.api.nvim_replace_termcodes('<ESC><CR>', true, false, true)
      vim.api.nvim_feedkeys(keys, 'm', false)
    end, 1000)
  end,
  silent = true,
  desc = 'Translate to EN'
})
