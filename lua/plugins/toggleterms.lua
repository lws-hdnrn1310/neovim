return {
	"akinsho/toggleterm.nvim",
	versions = "*",
	config = {
		--direction = "float",
	},
	keys = {
		{"<leader>tt", ":ToggleTerm<CR>"},
	},
	vim.keymap.set('t', '<esc>', "<C-\\><C-n>")
}
