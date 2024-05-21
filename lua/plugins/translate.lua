-- Google translate
return   {
  {
    'uga-rosa/translate.nvim',
    config = function()
      require("translate").setup({
        default = {
          command = "translate_shell",
          output = "insert",
          parse_before = "trim",
        },
      })
    end,
  },
}
