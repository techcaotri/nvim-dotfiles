return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    lazy = false, -- specify lazy = false because some lazy.nvim distributions set lazy = true by default
    -- tag = "*",
    dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},  -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = {      -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
          ["core.keybinds"] = {                -- Configure core.keybinds
            config = {
              default_keybinds = true,         -- Generate the default keybinds
              neorg_leader = "<LocalLeader>n", -- default neorg mapleader
              hook = function(kb)
                local neorg_prefix = "<LocalLeader>n"
                kb.map("norg", "n", neorg_prefix .. "e", function()
                  vim.cmd([[!norgc % gfm >/dev/null]])
                end, { desc = "Neorg: export to markdown and open file" })
                kb.map("norg", "n", neorg_prefix .. "E", function()
                  -- Get currently opened file name without extension
                  local filename = vim.fn.expand("%:t:r")
                  vim.cmd("Neorg export to-file " .. filename .. ".md")
                  vim.cmd.vsplit(vim.fn.expand("%:p:.:r") .. ".md")
                  vim.cmd([[MarkdownPreview]])
                end, { desc = "Neorg: export to markdown and open MarkdownPreview" })
                kb.map_event("norg", "n", neorg_prefix .. "c", "core.looking-glass.magnify-code-block")
                kb.map("norg", "n", neorg_prefix .. "q", "<Cmd>Neorg return<CR>")
              end,
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.integrations.nvim-cmp"] = {},
          ["core.integrations.telescope"] = {},
          ["core.export"] = {},
          ["core.export.markdown"] = { config = { extensions = "all" } },
          ["core.qol.toc"] = {},
          ["core.qol.todo_items"] = {},
          ["core.looking-glass"] = {},
          ["core.summary"] = {},
          ["core.ui.calendar"] = {},
        },
      }
    end,
  },
}
