return {
    {
    'nvimdev/lspsaga.nvim',
    -- 'lspsaga.nvim',
    -- dir = '/home/tripham/Dev/Playground_Terminal/Neovim_Awesome/lspsaga.nvim',
    after = 'nvim-lspconfig',
    config = function()
      require('lspsaga').setup({
        symbol_in_winbar = {
          enable = true,
        },
        finder = {
          max_height = 0.7,
          max_width = 0.7,
        },
        outline = {
          layout = 'float',
          win_width = 70,
        }
      })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons'      -- optional
    }
  },
}
