return{
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("noice").setup()
	end,
}
