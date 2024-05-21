return {
  {
    "akinsho/toggleterm.nvim",
    branch = "main",
    init = function()
      require("config.toggleterm_keymaps").init()
    end,
    cmd = {
      "ToggleTerm",
      "TermExec",
      "ToggleTermToggleAll",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
    },
  },
}
