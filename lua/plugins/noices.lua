return{
	"folke/noice.nvim",
	event = 'VeryLazy',
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("noice").setup()
	end,
}
