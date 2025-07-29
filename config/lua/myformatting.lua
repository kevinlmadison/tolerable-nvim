-- Conform
require("conform").setup({
	-- format_on_save = { lspFallback = true, timeoutMs = 2000 },
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

_G.format_with_conform = function()
	local conform = require("conform")
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 2000,
	})
end

vim.keymap.set(
	{ "n", "v" },
	"<leader>mp",
	":lua _G.format_with_conform()<CR>",
	{ desc = "[m]ake [p]retty by formatting", noremap = true, silent = true }
)
