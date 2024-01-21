return {
  "folke/flash.nvim",
  keys = {
    -- disable the default flash keymap
    { "s", mode = { "n", "x", "o" }, false },
    { "S", mode = { "n", "o", "x" }, false },
    { "<leader>S", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  },
}
