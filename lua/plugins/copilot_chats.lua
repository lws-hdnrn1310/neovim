return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "canary",
	dependencies = {
		{ "github/copilot.vim" },
		{ "nvim-lua/plenary.nvim" },
	},
	opts = {
		debug = false
	},
-- config = function()
-- 	function CopilotChatBuffer()
-- 		local input = vim.fn.input("Quick Chat: ")
-- 		if input ~= "" then
-- 			require("CopilotChat").ask(input, { selection = ("CopilotChat.select").buffer })
-- 		end
-- 	end
-- 	vim.api.nvim_set_keymap("n", "<leader>ccq", "<cmd>lua CopilotChatBuffer()<cr>", { noremap = true, silent = true})
--
-- 	function ShowCopilotActionPrompt()
-- 		local actions = require("CoplilotChat.actions")
-- 		require("CopilotChat.integrations.telescope").pick(actions.prompt_actions)
-- 	end
-- 	vim.api.nvim_set_keymap("n", "<leader>ccp", "<cmd>lua ShowCopilotActionPrompt()<cr>", { noremap = true, silent = true})
-- end
}
