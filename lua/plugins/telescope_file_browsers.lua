return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    -- config 関数の内部にキーマッピングを移動します
		vim.keymap.set('n', '<leader>fb', function()
      -- カレントバッファのディレクトリを取得する
      local current_buffer_directory = vim.fn.expand('%:h')
      -- カレントバッファにファイル名が関連付けられていない場合（例: 新規バッファ）、
      -- expand('%:h') は空文字列または '.' を返すことがあります。
      -- その場合は、カレントワーキングディレクトリを使用するなどのフォールバック処理を入れます。
      if current_buffer_directory == '' or current_buffer_directory == '.' then
        current_buffer_directory = vim.fn.getcwd() -- カレントワーキングディレクトリを取得
      end

      -- Telescope file_browser を指定したパスで開く
      require('telescope').extensions.file_browser.file_browser({
        path = current_buffer_directory,
      })
    end, { noremap = true, silent = true, desc = "Open file browser in current buffer's directory (using vim.keymap.set)" })
	end,
}
