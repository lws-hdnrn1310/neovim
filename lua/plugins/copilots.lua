return{
	"zbirenbaum/copilot.lua",
	cmd = { "Copilot" },
	event = { "InsertEnter" },
	config = function()
		require("copilot").setup({
      copilot_node_command = '/Users/h.ueno/.nodenv/versions/25.1.0/bin/node',
			suggestion = { enabled = true },
			panel = { enabled = false },
		})
	end,
}
