local M = {}

-- In order to disable a default keymap, use
-- M.disabled = {
--   n = {
--       ["<leader>h"] = "",
--       ["<C-a>"] = ""
--   }
-- }

-- Your custom mappings
M.abc = {
  n = {
    ["<C-S-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    ["<C-F12>"] = { "<cmd> Telescope lsp_document_symbols <CR>", "Telescope document symbols" },
  }
}

return M
