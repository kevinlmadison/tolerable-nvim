-- Gruvbox
--
-- Default options:
require("gruvbox").setup({
	terminal_colors = false, -- add neovim terminal colors
	undercurl = true,
	underline = false,
	bold = true,
	italic = {
		strings = true,
		emphasis = false,
		comments = true,
		operators = false,
		folds = true,
	},
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "", -- can be "hard", "soft" or empty string
	palette_overrides = {},
	overrides = {},
	dim_inactive = false,
	transparent_mode = true,
})
--
vim.o.background = "dark" -- or "light" for light mode
