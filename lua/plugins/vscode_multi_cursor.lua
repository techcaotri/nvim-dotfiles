return {
  'vscode-neovim/vscode-multi-cursor.nvim',
  event = 'VeryLazy',
  vscode = true,
  cond = not not vim.g.vscode,
  opts = {},
  config = function()
    vim.keymap.set({ "n", "x", "i" }, "<C-n>", function()
      require("vscode-multi-cursor").addSelectionToNextFindMatch()
    end)

    require('vscode-multi-cursor').setup()
  end
}
