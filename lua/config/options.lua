-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- image.nvim
-- package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
-- package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

if not vim.g.vscode then
  -- LazyVim loads this file while lazy.nvim is still sourcing plugin specs, so
  -- mason.setup() has not run yet and mason's registry list is empty. Without
  -- this, nvim-java's dependency check can't find java-debug-adapter, decides
  -- its packages are outdated, opens the Mason window over the buffer, and
  -- fires an unconditional (no-TTL) registry download on every startup.
  -- Register the registries here so the check succeeds. LazyVim's own
  -- require("mason").setup(opts) still runs later and de-duplicates.
  require('mason').setup({
    registries = {
      'github:nvim-java/mason-registry',
      'github:mason-org/mason-registry',
    },
  })

  require('java').setup({
    root_markers = {
      'settings.gradle',
      'settings.gradle.kts',
      'pom.xml',
      'build.gradle',
      'mvnw',
      'gradlew',
      'build.gradle',
      'build.gradle.kts'
    },
    -- jdtls = {
    --   version = 'v1.52.0',
    -- }
  })

  -- vim.lsp.config.jdtls.setup {
  --   -- ... other jdtls configurations ...
  --   root_dir = require('lspconfig.util').root_pattern(
  --     'settings.gradle',
  --     'settings.gradle.kts',
  --     'pom.xml',
  --     'build.gradle',
  --     'mvnw',
  --     'gradlew',
  --     'build.gradle',
  --     'build.gradle.kts'
  --   ),
  --   -- ...
  -- }
end

-- vscode-neovim undo/redo
if vim.g.vscode then
    -- undo/REDO via vscode
    vim.keymap.set("n","u","<Cmd>call VSCodeNotify('undo')<CR>")
    vim.keymap.set("n","<C-r>","<Cmd>call VSCodeNotify('redo')<CR>")
end
