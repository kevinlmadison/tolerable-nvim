-- Conform
require("conform").setup({
	-- format_on_save = { lspFallback = true, timeoutMs = 2000 },
	formatters_by_ft = {
		c = { "astyle" },
		cmake = { "cmake_format" },
		cpp = { "astyle" },
		css = { "prettierd", "prettier", "prettier-stylelint" },
		go = { "goimports", "gofumpt", "golines" },
		html = { "prettierd", "prettier", "prettier-stylelint" },
		javascript = { "prettierd", "prettier", "prettier-stylelint" },
		javascriptreact = { "prettier", "prettier-stylelint" },
		json = { "prettier", "prettier-stylelint" },
		lua = { "stylua" },
		markdown = { "prettier", "prettier-stylelint" },
		nix = { "alejandra" },
		python = { "isort", "black" },
		rust = { "rustfmt" },
		sh = { "shfmt" },
		typescript = { "prettierd", "prettier", "prettier-stylelint" },
		typescriptreact = { "prettier", "prettier-stylelint" },
		yaml = { "prettierd", "prettier", "prettier-stylelint" },
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
