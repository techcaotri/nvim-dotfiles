---@type NvPluginSpec[]
local plugins = { -- override plugin configs
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false
  }, -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end
  }, -- To make a plugin be loaded
  {
    "NvChad/nvim-colorizer.lua",
    lazy = false
  },
  -- All NvChad plugins are lazy-loaded by default
  -- Language Support
  -- -- Added this plugin.
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },         -- Required
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' },     -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  },
  {
    "williamboman/mason.nvim",
    opts = require("custom.config.lsp").mason_opts,
  },
  {
    "p00f/clangd_extensions.nvim",
    ft = require("custom.config.clangd-extensions").filetype,
    config = require("custom.config.clangd-extensions").config,
    dependencies = require("custom.config.clangd-extensions").dependencies,
  },
  {
    "neovim/nvim-lspconfig",
    config = require("custom.config.lsp").config,
    dependencies = require("custom.config.lsp").dependencies,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",

        -- web dev
        "javascript",
        "json",
        "typescript",
        "tsx",
        "css",

        -- other
        "python",
        "rust",
        "java",
        "yaml",
        "markdown",
        "markdown_inline",

        -- low level
        "bash",
        "c",

      } -- one of "all" or a list of languages
    }
  },
  {
    "nvim-treesitter/playground",
    lazy = false,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = require("custom.config.cmp").dependencies,
    opts = require("custom.config.cmp").opts,
  },
  {
    "zbirenbaum/copilot.lua",
    config = require("custom.config.copilot").config,
    dependencies = require("custom.config.copilot").dependencies,
  },
  {
    "aserowy/tmux.nvim",
    event = "VeryLazy",
    dependencies = {
      "gbprod/yanky.nvim",
      "folke/which-key.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      -- change the name of the module
      require "custom.config.tmux-yanky"
      -- or you can just copy-paste the config here.
    end,
  },
  -- {
  --   "olimorris/persisted.nvim",
  --   lazy = false,
  --   config = function()
  --     require("persisted").setup({ autoload = true })
  --     require("telescope").load_extension("persisted") -- To load the telescope extension
  --   end,
  -- },
  {
    'jedrzejboczar/possession.nvim',
    lazy = false,
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("possession").setup {
        autosave = {
          current = true,   -- or fun(name): boolean
          tmp = true,       -- or fun(): boolean
          tmp_name = 'tmp', -- or fun(): string
          on_load = true,
          on_quit = true,
        },
        plugins = {
          close_windows = {
            preserve_layout = true, -- or fun(win): boolean
            match = {
              floating = true,
              buftype = {
                'terminal',
              },
              filetype = {},
              custom = false, -- or fun(win): boolean
            },
          },
          delete_hidden_buffers = false,
          nvim_tree = true,
          -- tabby = true,
          delete_buffers = false,
        },
      }
      require('telescope').load_extension('possession')
    end,
  },
  { -- lazy.nvim
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find Files", ":Telescope find_files<cr>"),
        dashboard.button("e", " " .. " New Files", ":ene <BAR> startinsert <CR>"),
        dashboard.button("o", " " .. " Recent Files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find Text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Nvim Dev", [[<cmd>PossessionLoad Dev<CR>]]),
        dashboard.button("z", " " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
        (function()
          local group = { type = "group", opts = { spacing = 0 } }
          group.val = {
            {
              type = "text",
              val = "Sessions",
              opts = {
                position = "center"
              }
            }
          }
          local path = vim.fn.stdpath("data") .. "/possession"
          local files = vim.split(vim.fn.glob(path .. "/*.json"), "\n")
          for i, file in pairs(files) do
            local basename = vim.fs.basename(file):gsub("%.json", "")
            local button = dashboard.button(tostring(i), "  " .. basename,
              "<cmd>PossessionLoad " .. basename .. "<cr>")
            table.insert(group.val, button)
          end
          return group
        end)()
      }
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      require("alpha").setup(dashboard.opts)
    end,
  },
  {
    "Pocco81/auto-save.nvim",
    lazy = false,
    config = function()
      require("auto-save").setup {
        trigger_events = { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save. See :h events
        -- your config goes here
        debounce_delay = 1500,
        condition = function(buf)
          local fn = vim.fn
          local undotree = vim.fn.undotree()
          if undotree.seq_last ~= undotree.seq_cur then
            return false -- don't try to save again if I tried to undo. k thanks
          end
        end
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    init = function()
      require("core.utils").lazy_load "indent-blankline.nvim"
    end,
    opts = function()
      return require("custom.config.indent-blankline").blankline
    end,
    config = function(_, opts)
      require("core.utils").load_mappings "blankline"
      dofile(vim.g.base45_cache .. "blankline")
      require("indent_blankline").setup(opts)
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  { "folke/neodev.nvim", opts = {} },
  {
    "mbbill/undotree",
    lazy = false,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "fedepujol/move.nvim",
    lazy = false,
  },
  -- {
  -- "jose-elias-alvarez/null-ls.nvim",
  -- ft = require("custom.config.null-ls").filetype,
  -- config = require("custom.config.null-ls").config,
  -- dependencies = require("custom.config.null-ls").dependencies,
  -- },
  -- {
  -- "mfussenegger/nvim-dap",
  -- ft = require("custom.config.dap").filetype,
  -- config = require("custom.config.dap").config,
  -- dependencies = require("custom.config.dap").dependencies,
  -- },
  -- {
  -- "simrat39/rust-tools.nvim",
  -- ft = require("custom.config.rust-tools").filetype,
  -- config = require("custom.config.rust-tools").config,
  -- dependencies = require("custom.config.rust-tools").dependencies,
  -- },
  -- {
  -- "ThePrimeagen/refactoring.nvim",
  -- ft = require("custom.config.refactoring").filetype,
  -- config = require("custom.config.refactoring").config,
  -- },
  -- {
  -- "Civitasv/cmake-tools.nvim",
  -- ft = require("custom.config.cmake").filetype,
  -- config = require("custom.config.cmake").config,
  -- dependencies = require("custom.config.cmake").dependencies,
  -- },
  -- {
  -- "nvim-neotest/neotest",
  -- ft = require("custom.config.neotest").filetype,
  -- config = require("custom.config.neotest").config,
  -- dependencies = require("custom.config.neotest").dependencies,
  -- },
  -- {
  -- "kylechui/nvim-surround",
  -- lazy = true,
  -- event = "InsertEnter",
  -- config = require("custom.config.surround").config,
  -- },
  -- {
  -- "iamcco/markdown-preview.nvim",
  -- build = function()
  -- vim.fn["mkdp#util#install"]()
  -- end,
  -- ft = { "markdown" },
  -- },

  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
