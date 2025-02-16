return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "canary",
	dependencies = {
		{ "zbirenbaum/copilot.lua" },
		{ "nvim-lua/plenary.nvim" },
	},
	opts = {
		debug = false
	},
	config = function()
		local select = require('CopilotChat.select')
		require('CopilotChat').setup({
			prompts = {
				Explain = {
					prompt = '/COPILOT_EXPLAIN カーソル上のコードの説明を段落をつけて書いてください。',
				},
				Tests = {
					prompt = '/COPILOT_TESTS カーソル上のコードの詳細な単体テスト関数を書いてください。',
				},
				Fix = {
					prompt = '/COPILOT_FIX このコードには問題があります。バグを修正したコードに書き換えてください。',
				},
				Optimize = {
					prompt = '/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。',
				},
				Docs = {
					prompt = '/COPILOT_REFACTOR 選択したコードのドキュメントを書いてください。ドキュメントをコメントとして追加した元のコードを含むコードブロックで回答してください。使用するプログラミング言語に最も適したドキュメントスタイルを使用してください（例：JavaScriptのJSDoc、Pythonのdocstringsなど）',
				},
				FixDiagnostic = {
					prompt = 'ファイル内の次のような診断上の問題を解決してください：',
					selection = select.diagnostics,
				},
				Review = {
					prompt = '次のコードをレビューしてください：',
					selection = select.buffer,
				},
				Commit = {
					prompt = '次のコードをコミットしてください：',
					selection = select.buffer,
				},
				CommitMessage = {
					prompt = '次のコードに対するコミットメッセージを書いてください：',
					selection = select.buffer,
				},
			},
			mappings = {
				complete = {
					detail = 'Use @<Tab> or /<Tab> for options.',
					insert = '<Tab>',
				},
				close = {
					normal = 'q',
					insert = '<C-c>',
				},
				reset = {
					normal = '<C-r>',
					insert = '<C-r>',
				},
				submit_prompt = {
					normal = '<CR>',
					insert = '<C-s>',
				},
				accept_diff = {
					normal = '<C-y>',
					insert = '<C-y>',
				},
				yank_diff = {
					normal = 'gy',
				},
				show_diff = {
					normal = 'gd',
				},
				show_system_prompt = {
					normal = 'gp',
				},
				show_user_selection = {
					normal = 'gs',
				},
			},
		})

		function CopilotChatBuffer()
			local input = vim.fn.input("Quick Chat: ")
			if input ~= "" then
				require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
			end
		end
		vim.api.nvim_set_keymap("n", "<leader>ocs", "<cmd>CopilotChatToggle<cr>", { noremap = true, silent = true })

		vim.api.nvim_set_keymap("n", "<leader>ccq", "<cmd>lua CopilotChatBuffer()<cr>", { noremap = true, silent = true})

		function ShowCopilotActionPrompt()
			local actions = require("CopilotChat.actions")
			require("CopilotChat.integrations.telescope").pick(actions.prompt_actions)
		end
		vim.api.nvim_set_keymap("n", "<leader>ccp", "<cmd>lua ShowCopilotActionPrompt()<cr>", { noremap = true, silent = true})

	end
}
