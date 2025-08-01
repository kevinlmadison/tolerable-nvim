-- Treesitter
vim.opt.runtimepath:prepend(vim.fs.joinpath(vim.fn.stdpath("data"), "site"))
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	-- Enable injection queries for embedded languages
	injections = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = { init_selection = "<C-space>", node_decremental = "<bs>", node_incremental = "<C-space>" },
	},
	indent = { enable = true },
	parser_install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site"),
	textobjects = {
		move = {
			enable = true,
			goto_next_end = {
				["]C"] = { desc = "Next [c]lass end", query = "@class.outer" },
				["]F"] = { desc = "Next [f]unction call end", query = "@call.outer" },
				["]I"] = { desc = "Next cond[i]tional end", query = "@conditional.outer" },
				["]L"] = { desc = "Next [l]oop end", query = "@loop.outer" },
				["]M"] = { desc = "Next [m]ethod or function def end", query = "@function.outer" },
			},
			goto_next_start = {
				["]c"] = { desc = "Next [c]lass start", query = "@class.outer" },
				["]f"] = { desc = "Next [f]unction call start", query = "@call.outer" },
				["]i"] = { desc = "Next cond[i]tional start", query = "@conditional.outer" },
				["]l"] = { desc = "Next [l]oop start", query = "@loop.outer" },
				["]m"] = { desc = "Next [m]ethod or function def start", query = "@function.outer" },
				["]s"] = { desc = "Next [s]cope", query = "@scope", query_group = "locals" },
				["]z"] = { desc = "Next [f]old", query = "@fold", query_group = "folds" },
			},
			goto_previous_end = {
				["[C"] = { desc = "Prev [c]lass end", query = "@class.outer" },
				["[F"] = { desc = "Prev [f]unction call end", query = "@call.outer" },
				["[I"] = { desc = "Prev cond[i]tional end", query = "@conditional.outer" },
				["[L"] = { desc = "Prev [l]oop end", query = "@loop.outer" },
				["[M"] = { desc = "Prev [m]ethod or function def end", query = "@function.outer" },
			},
			goto_previous_start = {
				["[c"] = { desc = "Prev [c]lass start", query = "@class.outer" },
				["[f"] = { desc = "Prev [f]unction call start", query = "@call.outer" },
				["[i"] = { desc = "Prev cond[i]tional start", query = "@conditional.outer" },
				["[l"] = { desc = "Prev [l]oop start", query = "@loop.outer" },
				["[m"] = { desc = "Prev [m]ethod or function def start", query = "@function.outer" },
			},
			set_jumps = true,
		},
		select = {
			enable = true,
			keymaps = {
				["a="] = { desc = "Select [a]round outer part of an [=] assignment", query = "@assignment.outer" },
				aa = { desc = "Select [a]round the outer part of a p[a]rameter", query = "@parameter.outer" },
				ac = { desc = "Select [a]round the outer part of a [c]lass", query = "@class.outer" },
				af = { desc = "Select [a]round the outer part of a function call", query = "@call.outer" },
				ai = { desc = "Select [a]round the outer part of a cond[i]tional", query = "@conditional.outer" },
				al = { desc = "Select [a]round the outer part of a [l]oop", query = "@loop.outer" },
				am = { desc = "Select [a]round the outer part of [m]ethod or function", query = "@function.outer" },
				["i="] = { desc = "Select [i]nner part of an [=] assignment", query = "@assignment.inner" },
				ia = { desc = "Select the [i]nner part of a p[a]rameter", query = "@parameter.inner" },
				ic = { desc = "Select the [i]nner part of a [c]lass", query = "@class.inner" },
				["if"] = { desc = "Select the [i]nner part of a function call", query = "@call.inner" },
				ii = { desc = "Select the [i]nner part of a cond[i]tional", query = "@conditional.inner" },
				il = { desc = "Select the [i]nner part of a [l]oop", query = "@loop.inner" },
				im = { desc = "Select the [i]nner part of a [m]ethod or function", query = "@function.inner" },
				["l="] = { desc = "Select [l]eft hand side of an [=] assignment", query = "@assignment.lhs" },
				["r="] = { desc = "Select [r]ight hand side of an [=] assignment", query = "@assignment.rhs" },
			},
			lookahead = true,
		},
		swap = {
			enable = true,
			swap_next = { ["<leader>na"] = "@parameter.inner", ["<leader>nm"] = "@function.outer" },
			swap_previous = { ["<leader>pa"] = "@parameter.inner", ["<leader>pm"] = "@parameter.outer" },
		},
	},
})
