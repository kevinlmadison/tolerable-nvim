-- LSP
-- Common LSP key mappings
local function set_cmn_lsp_keybinds()
	local lsp_keybinds = {
		{
			key = "K",
			action = vim.lsp.buf.hover,
			options = {
				buffer = 0,
				desc = "hover [K]noledge with LSP",
			},
		},
		{
			key = "gd",
			action = vim.lsp.buf.definition,
			options = {
				buffer = 0,
				desc = "[g]o to [d]efinition with LSP",
			},
		},
		{
			key = "gy",
			action = vim.lsp.buf.type_definition,
			options = {
				buffer = 0,
				desc = "[g]o to t[y]pe definition with LSP",
			},
		},
		{
			key = "gi",
			action = vim.lsp.buf.implementation,
			options = {
				buffer = 0,
				desc = "[g]o to [i]mplementation with LSP",
			},
		},
		{
			key = "<leader>dj",
			action = vim.diagnostic.goto_next,
			options = {
				buffer = 0,
				desc = "Go to next [d]iagnostic with LSP",
			},
		},
		{
			key = "<leader>dk",
			action = vim.diagnostic.goto_prev,
			options = {
				buffer = 0,
				desc = "Go to previous [d]iagnostic with LSP",
			},
		},
		{
			key = "<leader>r",
			action = vim.lsp.buf.rename,
			options = {
				buffer = 0,
				desc = "[r]ename variable with LSP",
			},
		},
	}

	for _, bind in ipairs(lsp_keybinds) do
		vim.keymap.set("n", bind.key, bind.action, bind.options)
	end
end

-- Additional lsp-config
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Individual LSP configs
-- ansible LSP
require("lspconfig").ansiblels.setup({
	on_attach = function()
		set_cmn_lsp_keybinds()
	end,
})

-- bash LSP
require("lspconfig").bashls.setup({
	on_attach = function()
		set_cmn_lsp_keybinds()
	end,
})

-- clang LSP
require("lspconfig").clangd.setup({
	on_attach = function()
		set_cmn_lsp_keybinds()
	end,
})

-- cmake LSP
require("lspconfig").cmake.setup({
	on_attach = function()
		set_cmn_lsp_keybinds()
	end,
})

-- golang lsp
require("lspconfig").gopls.setup({
	on_attach = function()
		set_cmn_lsp_keybinds()
	end,
})

-- JSON lsp
require("lspconfig").jsonls.setup({
	on_attach = function()
		set_cmn_lsp_keybinds()
	end,
})

-- Lua LSP
require("lspconfig").lua_ls.setup({
	on_attach = function()
		set_cmn_lsp_keybinds()
	end,
})

-- Markdown LSP
require("lspconfig").marksman.setup({
	on_attach = function()
		set_cmn_lsp_keybinds()
	end,
})

-- Nix LSP
require("lspconfig").nil_ls.setup({
	on_attach = function()
		set_cmn_lsp_keybinds()
	end,
})

-- Nix LSP
-- require("lspconfig").nixd.setup({
-- 	on_attach = function()
-- 		set_cmn_lsp_keybinds()
-- 	end,
-- })

local venv_path = os.getenv("VIRTUAL_ENV")
local py_path = nil
-- decide which python executable to use for mypy
if venv_path ~= nil then
	py_path = venv_path .. "/bin/python3"
else
	py_path = vim.g.python3_host_prog
end

require("lspconfig").pylsp.setup({
	on_attach = custom_attach,
	settings = {
		pylsp = {
			plugins = {
				-- formatter options
				black = { enabled = true },
				autopep8 = { enabled = false },
				yapf = { enabled = false },
				-- linter options
				pylint = { enabled = false, executable = "pylint" },
				ruff = { enabled = true },
				pyflakes = { enabled = false },
				pycodestyle = { enabled = false },
				-- type checker
				pylsp_mypy = {
					enabled = true,
					overrides = { "--python-executable", py_path, true },
					report_progress = true,
					live_mode = false,
				},
				-- auto-completion options
				jedi_completion = { fuzzy = true },
				-- import sorting
				isort = { enabled = true },
			},
		},
	},
	flags = {
		debounce_text_changes = 200,
	},
	capabilities = capabilities,
})

-- Python LSP
require("lspconfig").ruff.setup({
	init_options = {
		settings = {
			-- Any extra CLI arguments for `ruff` go here.
			args = {},
		},
	},
})
-- require("lspconfig").ruff.setup({
-- 	on_attach = function()
-- 		set_cmn_lsp_keybinds()
-- 	end,
-- })

-- Rust LSP
require("lspconfig").rust_analyzer.setup({
	root_dir = function(fname)
		return vim.loop.cwd()
	end,
	settings = {
		["rust_analyzer"] = {
			cargo = {
				allFeatures = true,
			},
		},
	},
	on_attach = function()
		set_cmn_lsp_keybinds()
	end,
})

-- Typescript/Javascript LSP
require("lspconfig").ts_ls.setup({
	on_attach = function()
		set_cmn_lsp_keybinds()
	end,
})

require("typescript-tools").setup({
	on_attach = function()
		set_cmn_lsp_keybinds()
	end,
	settings = {
		-- spawn additional ts_ls instance to calculate diagnostics on it
		separate_diagnostic_server = true,
		-- "change"|"insert_leave" determine when the client asks the server about diagnostic
		publish_diagnostic_on = "insert_leave",
		-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
		-- "remove_unused_imports"|"organize_imports") -- or string "all"
		-- to include all supported code actions
		-- specify commands exposed as code_actions
		expose_as_code_action = {},
		-- string|nil - specify a custom path to `ts_ls.js` file, if this is nil or file under path
		-- not exists then standard path resolution strategy is applied
		ts_ls_path = nil,
		-- specify a list of plugins to load by ts_ls, e.g., for support `styled-components`
		-- (see 💅 `styled-components` support section)
		ts_ls_plugins = {},
		-- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
		-- memory limit in megabytes or "auto"(basically no limit)
		ts_ls_max_memory = "auto",
		-- described below
		ts_ls_format_options = {},
		ts_ls_file_preferences = {},
		-- locale of all ts_ls messages, supported locales you can find here:
		-- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
		ts_ls_locale = "en",
		-- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
		complete_function_calls = false,
		include_completions_with_insert_text = true,
		-- CodeLens
		-- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
		-- possible values: ("off"|"all"|"implementations_only"|"references_only")
		code_lens = "off",
		-- by default code lenses are displayed on all referencable values and for some of you it can
		-- be too much this option reduce count of them by removing member references from lenses
		disable_member_code_lens = true,
		-- JSXCloseTag
		-- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
		-- that maybe have a conflict if enable this feature. )
		jsx_close_tag = {
			enable = false,
			filetypes = { "javascriptreact", "typescriptreact" },
		},
	},
})

-- YAML LSP
require("lspconfig").yamlls.setup({
	on_attach = function()
		set_cmn_lsp_keybinds()
	end,
	settings = {
		yaml = {
			schemas = {
				kubernetes = "*.yaml",
				["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
				["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
				["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
				["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
				["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
				["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
				["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
				["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
				["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
				["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
				["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
			},
			format = {
				enable = true,
				singleQuote = false,
				bracketSpacing = true,
			},
			validate = true,
			completion = true,
		},
	},
})

-- Zig LSP
require("lspconfig").zls.setup({
	on_attach = function()
		set_cmn_lsp_keybinds()
	end,
})
