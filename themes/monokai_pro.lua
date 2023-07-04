local M = {}

M.base_30 = {
  white = "#f7f1ff",
  darker_black = "#131313",
  black = "#222222",
  black2 = "#313131",

  one_bg = "#3c3c3c",
  one_bg2 = "#525252",
  one_bg3 = "#646464",

  grey = "#888888",
  grey_fg = "#a2a2a2",
  grey_fg2 = "#bbbbbb",
  light_grey = "#cfcfcf",
  line = "#363942", -- for lines like vertsplit

  red = "#fc618d",
  baby_pink = "#ff85b1",
  pink = "#ff739f",

  line = "#484848",

  green = "#7bd88f",
  vibrant_green = "#85e299",

  nord_blue = "#27a1b3",
  blue = "#5ad4e6",

  yellow = "#fce566",
  sun = "#fff97a",

  purple = "#948ae3",
  dark_purple = "#6157b0",

  teal = "#5ad4e6",
  orange = "#fd9353",
  cyan = "#5ad4e6",

  statusline_bg = "#2c2c2c",
  lightbg = "#4d4d4d",
  lightbg2 = "#3e3e3e",
  pmenu_bg = "#7bd88f",
  folder_bg = "#5ad4e6",

  -- white = "#f5f4f1",
  -- darker_black = "#22231D",
  -- black = "#272822", --  nvim bg
  -- black2 = "#2F302A",
  -- one_bg = "#363731", -- real bg of onedark
  -- one_bg2 = "#3E3F39",
  -- one_bg3 = "#464741",
  -- grey = "#4D4E48",
  -- grey_fg = "#555650",
  -- grey_fg2 = "#5D5E58",
  -- light_grey = "#64655F",
  -- red = "#e36d76",
  -- baby_pink = "#f98385",
  -- pink = "#f36d76",
  -- line = "#363942", -- for lines like vertsplit
  -- green = "#96c367",
  -- vibrant_green = "#99c366",
  -- nord_blue = "#81A1C1",
  -- blue = "#51afef",
  -- yellow = "#e6c181",
  -- sun = "#fce668",
  -- purple = "#c885d7",
  -- dark_purple = "#b26fc1",
  -- teal = "#34bfd0",
  -- orange = "#d39467",
  -- cyan = "#41afef",
  -- statusline_bg = "#2F302A",
  -- lightbg = "#3E3F39",
  -- pmenu_bg = "#99c366",
  -- folder_bg = "#61afef",
}

M.base_16 = {
  base00 = "#222222",
  base01 = "#191919",
  base02 = "#131313",
  base03 = "#363537",
  base04 = "#525053",
  -- base05 = "#69676c",
  -- base06 = "#8b888f",
  -- base07 = "#bab6c0",
  base05 = "#f8f8f2",
  base06 = "#f5f4f1",
  base07 = "#f9f8f5",
  -- base07 = M.base_30.green,
  base08 = "#fd9353",
  base09 = "#948ae3",
  base0A = "#5ad4e6",
  base0B = "#fce566",
  base0C = "#5ad4e6",
  base0D = "#7bd88f",
  -- base0E = "#fc618d",
  base0E = "#fc618d",
  base0F = "#fc618d",

  -- base00 = "#272822",
  -- base01 = "#383830",
  -- base02 = "#49483e",
  -- base03 = "#75715e",
  -- base04 = "#a59f85",
  -- base05 = "#f8f8f2",
  -- base06 = "#f5f4f1",
  -- base07 = "#f9f8f5",
  -- base08 = "#fd971f",
  -- base09 = "#ae81ff",
  -- base0A = "#f4bf75",
  -- base0B = "#a6e22e",
  -- base0C = "#a1efe4",
  -- base0D = "#66d9ef",
  -- base0E = "#f92672",
  -- base0F = "#cc6633",
}

M.polish_hl = {
  ["@variable"] = { fg = M.base_30.green },
  ["@constant.macro"] = { fg = M.base_30.white, },
  ["@keyword"] = { fg = M.base_30.white, },
  ["@lsp.type.keyword"] = { fg = "#a6e22e", },
}

M.Variable = {
  fg = M.base_30.green,
}

-- local links = {
--   ['@lsp.type.namespace'] = '@namespace',
--   ['@lsp.type.type'] = '@type',
--   ['@lsp.type.class'] = '@type',
--   ['@lsp.type.enum'] = '@type',
--   ['@lsp.type.interface'] = '@type',
--   ['@lsp.type.struct'] = '@structure',
--   ['@lsp.type.parameter'] = '@parameter',
--   ['@lsp.type.variable'] = '@variable',
--   ['@lsp.type.property'] = '@property',
--   ['@lsp.type.enumMember'] = '@constant',
--   ['@lsp.type.function'] = '@function',
--   ['@lsp.type.method'] = '@method',
--   ['@lsp.type.macro'] = '@macro',
--   ['@lsp.type.decorator'] = '@function',
--   ["@lsp.type.keyword"] = '@keyword',
-- }
-- for newgroup, oldgroup in pairs(links) do
--   vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
-- end

M.type = "dark"

M = require("base46").override_theme(M, "monokai_pro")

return M

-- dark2 = "#131313",
-- dark1 = "#191919",
-- background = "#222222",
-- text = "#f7f1ff"
-- accent1 = "#fc618d",
-- accent2 = "#fd9353",
-- accent3 = "#fce566",
-- accent4 = "#7bd88f",
-- accent5 = "#5ad4e6",
-- accent6 = "#948ae3",
-- dimmed1 = "#bab6c0",
-- dimmed2 = "#8b888f",
-- dimmed3 = "#69676c",
-- dimmed4 = "#525053",
-- dimmed5 = "#363537",
