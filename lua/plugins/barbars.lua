return {
	'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
		config = function()
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }
			-- Move to previous/next
			map('n', 'tp', '<Cmd>BufferPrevious<CR>', opts)
			map('n', 'tn', '<Cmd>BufferNext<CR>', opts)
			-- Pin/unpin buffer
			map('n', '<leader>p', '<Cmd>BufferPin<CR>', opts)
			-- Close buffer
			map('n', '<leader>bd', '<Cmd>BufferClose<CR>', opts)
			map('n', '<leader>bad', '<Cmd>:BufferCloseAllButPinned<CR>', opts)
		end
}


