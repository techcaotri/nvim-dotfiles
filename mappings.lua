local M = {}

-- In order to disable a default keymap, use
-- M.disabled = {
--   n = {
--       ["<leader>h"] = "",
--       ["<C-a>"] = ""
--   }
-- }

-- Your custom mappings
M.nvimtree = {
  n = {
    ["<C-S-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvim-tree" },
  }
}

M.lsp = {
  n = {
    ["<C-F12>"] = { "<cmd> Telescope lsp_document_symbols <CR>", "Telescope document symbols" },
  }
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end
      vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = desc })
    end
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

    nmap('<leader>ra', vim.lsp.buf.rename, '[R]e n[a]me')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  end,
})

M.undotree = {
  n = {
    ["<leader>tu"] = { "<cmd> UndotreeToggle <CR>", "Toggle undotree" },
  }
}

M.possession = {
  n = {
    ["<leader>ss"] = {
      function()
        local possession_name = vim.fn.input("PossessionSave name, use 'tmp' if empty: ")
        local possession = require("possession")
        if possession_name == nil or possession_name == "" then
          possession_name = "tmp"
        end
        possession.save(possession_name)
      end,
      "Save session with prompt" },

  }
}

return M
