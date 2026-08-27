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

		-- <Tab> で複数選択したエントリをまとめて buffer として開くアクション。
		-- find_files / live_grep など全ピッカー共通で使う。
		-- 複数選択が無ければ既定の <CR>（select_default）に委ねる。
		local open_multi_selection = function(prompt_bufnr)
			local picker = action_state.get_current_picker(prompt_bufnr)
			local selections = picker:get_multi_selection()

			if #selections == 0 then
				return actions.select_default(prompt_bufnr)
			end

			actions.close(prompt_bufnr)

			-- grep 結果なら filename、ファイル系なら path/value に入る
			local function entry_path(entry)
				return entry.filename or entry.path or entry.value
			end

			-- すべて buffer に追加（grep 結果は該当行を指定して開く）
			for _, entry in ipairs(selections) do
				local path = entry_path(entry)
				if path then
					vim.cmd(string.format('badd +%d %s', entry.lnum or 1, vim.fn.fnameescape(path)))
				end
			end

			-- 最初のエントリを表示し、行があればジャンプ
			local first = selections[1]
			local first_path = entry_path(first)
			if first_path then
				vim.cmd('buffer ' .. vim.fn.fnameescape(first_path))
				if first.lnum then
					pcall(vim.api.nvim_win_set_cursor, 0, { first.lnum, (first.col or 1) - 1 })
				end
			end
		end

		-- カスタムアクションを定義
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
						['<C-t>'] = open_in_iterm, -- インサートモードでCtrl+tを押した時に実行
						['<CR>'] = open_multi_selection, -- 複数選択を一括で開く（未選択時は通常の開く挙動）
					},
					n = {
						['<C-t>'] = open_in_iterm, -- ノーマルモードでCtrl+tを押した時に実行
						['<CR>'] = open_multi_selection,
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
