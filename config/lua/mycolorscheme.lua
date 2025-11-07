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

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.cmd [[
      hi Normal guibg=NONE ctermbg=NONE
      hi NormalNC guibg=NONE ctermbg=NONE
      hi SignColumn guibg=NONE ctermbg=NONE
      hi LineNr guibg=NONE ctermbg=NONE
      hi EndOfBuffer guibg=NONE ctermbg=NONE
    ]]
  end,
})

vim.cmd("colorscheme onedark")

return colorschemes
