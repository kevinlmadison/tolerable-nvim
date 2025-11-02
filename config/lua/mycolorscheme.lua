-- Import all colorscheme configs
local colorschemes = {
  require("colorschemes.gruvbox"),
  require("colorschemes.tokyonight"),
  require("colorschemes.rose-pine"),
  require("colorschemes.kanagawa"),
}

vim.cmd("colorscheme tokyonight-night")

return colorschemes
