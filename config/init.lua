vim.g.mapleader = " "
vim.cmd.colorscheme("gruvbox")

vim.notify("We're running at least...", vim.log.levels.INFO)

vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.colorcolumn = "80"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.cursorcolumn = true
vim.opt.expandtab = true
vim.opt.foldlevelstart = 99
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.listchars = "trail:¬,precedes:«,extends:»,tab:→⋅"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.wrap = true

-- Set up autocommands {{
do
	local __nixvim_autocommands = {
		{
			callback = function()
				require("lint").try_lint()
			end,
			event = "BufWritePost",
		},
	}

	for _, autocmd in ipairs(__nixvim_autocommands) do
		vim.api.nvim_create_autocmd(autocmd.event, {
			group = autocmd.group,
			pattern = autocmd.pattern,
			buffer = autocmd.buffer,
			desc = autocmd.desc,
			callback = autocmd.callback,
			command = autocmd.command,
			once = autocmd.once,
			nested = autocmd.nested,
		})
	end
end
-- }}
-- --
-- vim.cmd([[let $BAT_THEME = 'gruvbox'
--
-- colorscheme gruvbox
-- ]])

require("mini.icons").setup({})
MiniIcons.mock_nvim_web_devicons()

-- Clipboard Sync
vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
	},
}

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "[y]ank to system clipboard", noremap = true, silent = true })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "[Y]ank line to system clipboard", noremap = true, silent = true })

-- Toggle vertical cursor column
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "[Y]ank line to system clipboard", noremap = true, silent = true })
vim.keymap.set(
	"n",
	"<C-y>",
	":set cursorcolumn!<CR>",
	{ desc = "Toggle vertical column because [Y]AML sucks", noremap = true, silent = true }
)

-- Move selected line(s) down/up in visual mode
vim.keymap.set(
	"v",
	"J",
	":m '>+1<CR>gv=gv",
	{ desc = "Shift line down 1 in visual mode", noremap = true, silent = true }
)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Shift line up 1 in visual mode", noremap = true, silent = true })

-- Keep cursor position when joining lines
vim.keymap.set("n", "J", "mzJ`z", { noremap = true, silent = true })

-- Half-page jumping centers cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Search results centered
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

-- Paste without overwriting the unnamed register
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "[p]reserve put", noremap = true, silent = true })

-- Tmux sessionizer
vim.keymap.set(
	"n",
	"<C-f>",
	"<cmd>!tmux new tmux-sessionizer<CR>",
	{ desc = "[f]ind and switch tmux session", noremap = true, silent = true }
)

-- Quickfix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix", noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Prev quickfix", noremap = true, silent = true })

-- Location list navigation
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next quickfix location", noremap = true, silent = true })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev quickfix location", noremap = true, silent = true })

-- Local Plugin Configs
require("mycompletion")
require("mydebugging")
require("myformatting")
require("mygitsigns")
require("myharpoon")
require("mylinting")
require("mylsp")
require("mylualine")
require("mytreesitter")

-- Telescope
local builtin = require("telescope.builtin")
require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")

vim.keymap.set("n", "<Leader>?", builtin.oldfiles)
vim.keymap.set("n", "<Leader>/", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<Leader><space>", builtin.buffers)
vim.keymap.set("n", "<Leader>sf", builtin.find_files)
vim.keymap.set("n", "<Leader>sd", builtin.diagnostics)
vim.keymap.set("n", "<Leader>sg", builtin.live_grep)
vim.keymap.set("n", "<Leader>sh", builtin.help_tags)
vim.keymap.set("n", "<Leader>sw", builtin.grep_string)
vim.keymap.set("n", "<Leader>ss", builtin.git_files)
vim.keymap.set("n", "<Leader>sk", builtin.keymaps)

-- Null-ls
require("null-ls").setup({
	root_dir = require("null-ls.utils").root_pattern(".git"),
	sources = {
		-- General
		require("null-ls").builtins.formatting.prettier,
		-- Python
		require("null-ls").builtins.formatting.black,
		require("null-ls").builtins.diagnostics.mypy,
		-- Nix
		require("null-ls").builtins.code_actions.statix,
		require("null-ls").builtins.diagnostics.statix,
		require("null-ls").builtins.formatting.alejandra,
		-- Yaml
		require("null-ls").builtins.diagnostics.ansiblelint,
		require("null-ls").builtins.diagnostics.yamllint,
		require("null-ls").builtins.formatting.yamlfmt,
		-- C/C++
		require("null-ls").builtins.formatting.astyle,
		require("null-ls").builtins.formatting.clang_format,
		require("null-ls").builtins.diagnostics.cppcheck,
		-- Lua
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.completion.luasnip,
		require("null-ls").builtins.diagnostics.selene,
	},
})

-- Set up Codeium/Windsurf
do
	local codeium_configs = {
		codeium_disable_bindings = true,
		codeium_enabled = true,
		codeium_no_map_tab = true,
		mapleader = " ",
		skip_ts_context_commentstring_module = true,
	}

	for k, v in pairs(codeium_configs) do
		vim.g[k] = v
	end
end

vim.keymap.set(
	"i",
	"<C-a>",
	"codeium#Accept()",
	{ desc = "codeium Accept", expr = true, nowait = true, script = true, silent = true }
)
vim.keymap.set(
	"i",
	"<C-;>",
	"<cmd>call codeium#CycleCompletions(1)<cr>",
	{ desc = "Toggle Trouble LSP References", expr = true, silent = true }
)
vim.keymap.set(
	"i",
	"<C-,>",
	"<cmd>call codeium#CycleCompletions(-1)<cr>",
	{ desc = "Toggle Trouble LSP References", expr = true, silent = true }
)
vim.keymap.set(
	"i",
	"<C-x>",
	"<cmd>call codeium#Clear()<cr>",
	{ desc = "Toggle Trouble LSP References", expr = true, silent = true }
)

-- Cursorline
require("nvim-cursorline").setup({ cursorline = { enable = true, number = true, timeout = 0 } })

-- NVim Tree
require("nvim-tree").setup({ hijack_directories = { auto_open = false } })
vim.keymap.set(
	"n",
	"<leader>t",
	"<cmd>NvimTreeToggle<CR>",
	{ desc = "Toggle nvim [t]ree", noremap = true, silent = true }
)

-- Undo Tree
vim.keymap.set(
	"n",
	"<leader>u",
	"<cmd>UndotreeToggle<CR>",
	{ desc = "[u]ndotree toggle", noremap = true, silent = true }
)

-- Oil
require("oil").setup({})
vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>", { desc = "[p]roject [v]iew", noremap = true, silent = true })

-- Flash
require("flash").setup({})

-- Indent Blankline
require("ibl").setup({})

-- LuaSnip
require("luasnip").config.setup({})
require("luasnip.loaders.from_vscode").lazy_load({})

-- Surround
require("nvim-surround").setup({})

-- Navic
require("nvim-navic").setup({})

-- Nvim Autopairs
require("nvim-autopairs").setup({ check_ts = true })

-- Trouble
require("trouble").setup({})
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xX",
	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	{ desc = "Buffer Diagnostics (Trouble)" }
)
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>cl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- TS Context Commentstring
-- Comment
require("ts_context_commentstring").setup({})
require("Comment").setup({})

-- Which-Key
require("which-key").setup({})

-- Autopairs
require("nvim-autopairs").setup({ check_ts = true })

-- UFO (Folds)
require("ufo").setup({
	providerSelector = "function(bufnr, filetype, buftype)\n \t\t\treturn { 'treesitter', 'indent' }\n \t\tend\n",
})
vim.keymap.set("n", "zK", function()
	local winid = require("ufo").peekFoldedLinesUnderCursor()
	if not winid then
		vim.lsp.buf.hover()
	end
end, { desc = "Pee[k] fold" })
