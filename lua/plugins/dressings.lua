return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	keys = {
		-- test functions
		{"<leader>sl", ":lua vim.ui.select({'one', 'two'}, {}, function(selection) print(selection) end)<CR>"},
		{"<leader>it", ":lua vim.ui.input({prompt = \"Enter input: \"}, function(input) print(input) end)<CR>"},
	},
}
