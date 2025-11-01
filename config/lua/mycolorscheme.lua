-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = function()
--     vim.cmd [[
--       hi Normal guibg=NONE ctermbg=NONE
--       hi NormalNC guibg=NONE ctermbg=NONE
--       hi SignColumn guibg=NONE ctermbg=NONE
--       hi LineNr guibg=NONE ctermbg=NONE
--       hi EndOfBuffer guibg=NONE ctermbg=NONE
--     ]]
--   end,
-- })

-- vim.cmd("colorscheme zaibatsu")
-- vim.cmd("colorscheme colibri")


-- Gruvbox
--
-- Default options:
require("gruvbox").setup({
	terminal_colors = true, -- add neovim terminal colors
	undercurl = true,
	underline = true,
	bold = true,
	italic = {
		strings = true,
		emphasis = true,
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
	transparent_mode = false,
})
--
-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])

-- Gruber-Darker
-- vim.cmd([[colorscheme gruber-darker]])

-- Kanagawa
--
-- Default options:
require("kanagawa").setup({
	compile = false, -- enable compiling the colorscheme
	undercurl = true, -- enable undercurls
	commentStyle = { italic = true },
	functionStyle = {},
	keywordStyle = { italic = true },
	statementStyle = { bold = true },
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

-- setup must be called before loading
-- vim.cmd("colorscheme kanagawa")

require("rose-pine").setup({
    variant = "auto", -- auto, main, moon, or dawn
    dark_variant = "main", -- main, moon, or dawn
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
    },

    styles = {
        bold = true,
        italic = true,
        transparency = false,
    },

    groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
    },

    palette = {
        -- Override the builtin palette per variant
        -- moon = {
        --     base = '#18191a',
        --     overlay = '#363738',
        -- },
    },

	-- NOTE: Highlight groups are extended (merged) by default. Disable this
	-- per group via `inherit = false`
    highlight_groups = {
        -- Comment = { fg = "foam" },
        -- StatusLine = { fg = "love", bg = "love", blend = 15 },
        -- VertSplit = { fg = "muted", bg = "muted" },
        -- Visual = { fg = "base", bg = "text", inherit = false },
    },

    before_highlight = function(group, highlight, palette)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --     highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        -- if highlight.fg == palette.pine then
        --     highlight.fg = palette.foam
        -- end
    end,
})

vim.cmd("colorscheme rose-pine")
