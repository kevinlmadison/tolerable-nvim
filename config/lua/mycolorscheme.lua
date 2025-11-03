-- Import all colorscheme configs
local colorschemes = {
  require("colorschemes.gruvbox"),
  require("colorschemes.tokyonight"),
  require("colorschemes.rose-pine"),
  require("colorschemes.kanagawa"),
  require("colorschemes.catppuccin"),
  -- require("colorschemes.nord"),
  -- require("colorschemes.nordic"),
  require("colorschemes.onedark"),
}


vim.cmd("colorscheme onedark")

return colorschemes
