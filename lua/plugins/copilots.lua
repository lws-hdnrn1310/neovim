return{
	"zbirenbaum/copilot.lua",
	cmd = { "Copilot" },
	event = { "InsertEnter" },
	config = function()
		require("copilot").setup({
			copilot_node_command = '/Users/h.ueno/.nodenv/versions/25.1.0/bin/node',
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = false,
					accept_word = "<C-Right>",
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
			panel = { enabled = false },
		})
	end,
}
