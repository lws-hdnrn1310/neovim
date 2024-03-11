return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make"
		},
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{"<leader>ff", ":Telescope find_files find_command=rg,--files,--hidden,--glob,!*.git<CR>"},
		{"<leader>lg", ":Telescope live_grep<CR>" },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
				},
			},
			extensions = {
				fzf = {
					fuzzy = false,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				}
			}
		});
		require("telescope").load_extension("fzf")
	end
		-- dropdown
		-- git_commits
		-- git_branchs
}
