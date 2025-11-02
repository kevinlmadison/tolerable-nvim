
-- Kanagawa
--
-- Default options:
require("kanagawa").setup({
	compile = false, -- enable compiling the colorscheme
	undercurl = true, -- enable undercurls
	commentStyle = { italic = true },
	functionStyle = {},
	keywordStyle = { italic = false },
	statementStyle = { bold = false },
	typeStyle = {},
	transparent = false, -- do not set background color
	dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	terminalColors = true, -- define vim.g.terminal_color_{0,17}
	colors = { -- add/modify theme and palette colors
		palette = {},
		theme = {
			wave = {},
			lotus = {},
			dragon = {},
			all = {
				ui = {
					bg_gutter = "none",
				},
			},
		},
	},
	overrides = function(colors)
		local theme = colors.theme
		return {
			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },

			-- Save an hlgroup with dark background and dimmed foreground
			-- so that you can use it where your still want darker windows.
			-- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
			NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

			-- TelescopeTitle = { fg = theme.ui.special, bold = true, blend = vim.o.pumblend },
			-- TelescopePromptNormal = { bg = theme.ui.bg_p1, blend = vim.o.pumblend },
			-- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
			-- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1, blend = vim.o.pumblend },
			-- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1, blend = vim.o.pumblend },
			-- TelescopePreviewNormal = { bg = theme.ui.bg_dim, blend = vim.o.pumblend },
			-- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim, blend = vim.o.pumblend },

			Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
			PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2, blend = vim.o.pumblend },
			PmenuSbar = { bg = theme.ui.bg_m1, blend = vim.o.pumblend },
			PmenuThumb = { bg = theme.ui.bg_p2, blend = vim.o.pumblend },
		}
	end,
	theme = "wave", -- Load "wave" theme
	background = { -- map the value of 'background' option to a theme
		dark = "wave", -- try "dragon" !
		light = "lotus",
	},
})
