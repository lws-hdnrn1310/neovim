return{
	"nvim-telescope/telescope-file-browser.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},

	vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope file_browser<cr>', { noremap = true, silent = true })
}
