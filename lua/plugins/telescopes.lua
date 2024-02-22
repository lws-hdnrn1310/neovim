return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim",
			build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{"<leader>ff", ":Telescope find_files theme=dropdown find_command=rg,--files,--hidden,--glob,!*.git<CR>"},
		{"<leader>lg", ":Telescope live_grep theme=dropdown<CR>" },
	},
	config = function()
		local telescope = require("telescope")

		telescope.load_extension("fzf");
		-- dropdown
		-- git_commits
		-- git_branchs
	end
}
