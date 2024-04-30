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
		{"<leader>ff", ":Telescope find_files find_command=rg,--sort-files,--files,--hidden,--glob,!*.git<CR>"},
		{"<leader>lg", ":Telescope live_grep<CR>" },
	},
	config = function()
		local actions = require('telescope.actions')
		local action_state = require('telescope.actions.state')

		-- カスタムアクションを定義
		local open_in_iterm = function(prompt_bufnr)
      local selection = action_state.get_selected_entry()
			local file_path = selection.value
			local file_dir = '~/Dev/arukuto_server_h-ueno/'

			file_path = file_path:gsub(":%d+:%d+:.*$", "")
      actions.close(prompt_bufnr)
      local command = 'osascript -e \'tell application "iTerm"\' ' ..
                      '-e \'set myWindow to (create window with profile "ForNvim")\' ' ..
                      '-e \'tell current session of myWindow\' ' ..
                      '-e \'write text "cd '.. file_dir..' && nvim ' .. file_path .. '"\' ' ..
                      '-e \'end tell\' ' ..
                      '-e \'end tell\''
      os.execute(command)
    end

		require("telescope").setup{
			defaults = {
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
				},
				vimgrep_arguments = {
						'rg', '--color=never', '--no-heading', '--with-filename',
						'--line-number', '--column', '--smart-case', '--sort-files'
				},
				mappings = {
					i = {
						['<C-t>'] = open_in_iterm, -- インサートモードでCtrl+tを押した時に実行
					},
					n = {
						['<C-t>'] = open_in_iterm, -- ノーマルモードでCtrl+tを押した時に実行
					},
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
		}
		require("telescope").load_extension("fzf")
	end
}
