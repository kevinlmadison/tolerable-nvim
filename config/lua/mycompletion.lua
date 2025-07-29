-- Completion (CMP)
local cmp = require("cmp")
cmp.setup({
	completion = { completeopt = "menu,menuone,noinsert" },
	mapping = {
		["<c-space>"] = cmp.mapping.complete({}),
		["<c-d>"] = cmp.mapping.scroll_docs(-4),
		["<c-f>"] = cmp.mapping.scroll_docs(4),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	performance = { max_view_entries = 16 },
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
	},
	window = { documentation = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } } },
})

cmp.setup.cmdline("/", { mapping = cmp.mapping.preset.cmdline(), sources = { { name = "buffer" } } })

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "path" }, { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } } },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

-- Extra options for cmp-cmdline setup
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
