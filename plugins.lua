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
