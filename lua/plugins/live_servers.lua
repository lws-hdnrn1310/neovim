return {
	'barrett-ruth/live-server.nvim',
	build = 'npm add -g live-server',
	cmd = { 'LiverServerStart', 'LiveServerStop' },
	config = function()
		require('live-server').setup({
			liver_command = 'live',
			liver_args = { '--port', '8080' },
			liver_autostart = true,
		})
	end
}
