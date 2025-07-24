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

-- Harpoon
require("harpoon"):setup({})
-- Set up keybinds {{{
do
	local harpoon_keymaps = {

		{
			action = function()
				require("harpoon"):list():add()
			end,
			key = "<leader>a",
			mode = "n",
		},
		{
			action = function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
			key = "<C-e>",
			mode = "n",
		},
		{
			action = function()
				require("harpoon"):list():select(1)
			end,
			key = "<C-j>",
			mode = "n",
		},
		{
			action = function()
				require("harpoon"):list():select(2)
			end,
			key = "<C-k>",
			mode = "n",
		},
		{
			action = function()
				require("harpoon"):list():select(3)
			end,
			key = "<C-l>",
			mode = "n",
		},
		{
			action = function()
				require("harpoon"):list():select(4)
			end,
			key = "<C-m>",
			mode = "n",
		},
	}
	for i, map in ipairs(harpoon_keymaps) do
		vim.keymap.set(map.mode, map.key, map.action, map.options)
	end
end

-- DAP Config
local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

local dap = require("dap")
dap.set_log_level("DEBUG")

dap.adapters.lldb = {
	type = "executable",
	command = "lldb", -- adjust as needed, must be absolute path
	name = "lldb",
}

local dap = require("dap")
dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "-i", "dap" },
}

local dap = require("dap")
dap.configurations.c = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path of the executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
	},
}

local dap = require("dap")
dap.configurations.rust = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path of the executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}

dap.configurations.zig = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Root path of executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}

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

-- Conform
require("conform").setup({
	format_on_save = { lspFallback = true, timeoutMs = 2000 },
	formatters_by_ft = {
		c = { "astyle" },
		cmake = { "cmake_format" },
		cpp = { "astyle" },
		css = { "prettierd", "prettier" },
		go = { "goimports", "gofumpt", "golines" },
		html = { "prettierd", "prettier" },
		javascript = { "prettierd", "prettier" },
		javascriptreact = { "prettier" },
		json = { "prettier" },
		lua = { "stylua" },
		markdown = { "prettier" },
		nix = { "alejandra" },
		python = { "isort", "black" },
		rust = { "rustfmt" },
		sh = { "shfmt" },
		typescript = { "prettierd", "prettier" },
		typescriptreact = { "prettier" },
		yaml = { "prettierd", "prettier" },
	},
})

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
