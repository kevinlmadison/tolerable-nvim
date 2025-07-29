-- Harpoon
require("harpoon"):setup({})
do
	local harpoon_keymaps = {

		{
			action = function()
				require("harpoon"):list():add()
			end,
			key = "<leader>a",
			mode = "n",
			options = { desc = "[A]dd file to harpoon" },
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
