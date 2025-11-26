-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- image.nvim
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

if not vim.g.vscode then
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
    jdtls = {
      version = 'v1.52.0',
    }
  })

  require('lspconfig').jdtls.setup {
    -- ... other jdtls configurations ...
    root_dir = require('lspconfig.util').root_pattern(
      'settings.gradle',
      'settings.gradle.kts',
      'pom.xml',
      'build.gradle',
      'mvnw',
      'gradlew',
      'build.gradle',
      'build.gradle.kts'
    ),
    -- ...
  }
end
