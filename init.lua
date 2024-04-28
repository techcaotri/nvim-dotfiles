-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local isTermux = string.find(
  os.getenv("PREFIX") or "nil",
  "termux"
)

local vim = vim
local opt = vim.opt

if isTermux then
  opt.tabstop = 2
  opt.shiftwidth = 2
else
  opt.tabstop = 4
  opt.shiftwidth = 4
end

local exclude = {
  -- lsp you want to exclude
  -- example
  -- 'clangd',
}

if isTermux then
  exclude = {
    'clangd',
    'rust_analyzer',
    'lua_ls'
  }
end

-- local mason = require('mason-lspconfig')
local have_mason, mason = pcall(require, "mason-lspconfig")
mason.setup({
  automatic_installation = {
    exclude = exclude
  }
})

local lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local function setup(server)
  lsp[server].setup({
    capabilities = capabilities
  })
end
mason.setup_handlers({
  setup
})

if isTermux then
  -- lsp installed outside mason
  -- example:
  --
  setup('clangd')
  setup('rust_analyzer')
  setup('lua_ls')
end
