-- DAP Config
require("nvim-dap-virtual-text").setup({})

require("dapui").setup({})

require("dap-python").setup("/nix/store/g7vsa82m2qsx8s9pp7clfxm45i61z562-python3-3.13.5-env/bin/python3.13", {})

require("dap-go").setup({})

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
-- Debug Adapter Protocol (DAP) keymaps

-- Toggle / set breakpoints
vim.keymap.set(
	"n",
	"<leader>b",
	":lua require'dap'.toggle_breakpoint()<CR>",
	{ desc = "Toggle DAP [b]reakpoint", noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<leader>B",
	":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Set DAP [B]reakpoint", noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<leader>lp",
	":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
	{ desc = "[l]og DAP [p]oint message", noremap = true, silent = true }
)

-- Go debugging helpers
vim.keymap.set(
	"n",
	"<leader>dtg",
	":lua require'dap-go'.debug_test()<CR>",
	{ desc = "DAP [d]ebug [t]est for (g)o", noremap = true, silent = true }
)

-- REPL
vim.keymap.set(
	"n",
	"<leader>de",
	":lua require'dap'.repl.open()<CR>",
	{ desc = "[d]ap r[e]pl open", noremap = true, silent = true }
)

-- Execution controls
vim.keymap.set(
	"n",
	"<F5>",
	":lua require'dap'.continue()<CR>",
	{ desc = "Continue DAP debug", noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<F10>",
	":lua require'dap'.step_over()<CR>",
	{ desc = "Step over DAP debug", noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<F11>",
	":lua require'dap'.step_into()<CR>",
	{ desc = "Step into DAP debug", noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<F12>",
	":lua require'dap'.step_out()<CR>",
	{ desc = "Step out of DAP debug", noremap = true, silent = true }
)
