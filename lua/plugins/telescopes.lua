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
		-- find_files のキーバインドを再びシンプルな形に戻します
		-- sorter の指定を削除し、グローバル設定に任せる
		{"<leader>ff", ":Telescope find_files find_command=rg,--sort-files,--files,--hidden,--glob,!*.git<CR>", desc = "Find Files"},
		{"<leader>lg", ":Telescope live_grep<CR>" },
	},
	config = function()
		local actions = require('telescope.actions')
		local action_state = require('telescope.actions.state')

		-- カスタムアクションを定義 (変更なし)
		local open_in_iterm = function(prompt_bufnr)
			local selection = action_state.get_selected_entry()
			local file_path = selection.value
			local file_dir = os.getenv('WORKSPACE_DIR')

			if file_dir then
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
		end

		require("telescope").setup{
			defaults = {
				-- ここが重要: sorting_strategy を "ascending" に設定
				sorting_strategy = "ascending",
				layout_config = {
					prompt_position = "top",
				},
				vimgrep_arguments = {
						'rg', '--color=never', '--no-heading', '--with-filename',
						'--line-number', '--column', '--smart-case', '--sort-files',
						-- live_grepの検索対象から除外する
						'--glob=!node_modules/*', '--glob=!public/*', '--glob=!vendor/*',
				},
				mappings = {
					i = {
						['<C-t>'] = open_in_iterm,
					},
					n = {
						['<C-t>'] = open_in_iterm,
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = false,
					-- **** ここを両方 false にします (再確認) ****
					-- FZFによる汎用ソートもファイルソートも無効化し、Telescopeのデフォルトに任せる
					override_generic_sorter = false,
					override_file_sorter = false,
					case_mode = "smart_case",
				}
			}
		}
		require("telescope").load_extension("fzf")
	end
}
