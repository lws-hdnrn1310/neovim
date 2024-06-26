return {
	'neovim/nvim-lspconfig',
	'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
	config = function()
		-- プラグインの設定
		require("mason").setup()
		require("mason-lspconfig").setup()
		require("mason-lspconfig").setup_handlers {
			function(server_name)
				require("lspconfig")[server_name].setup {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				}
			end,
		}
	end,
}
