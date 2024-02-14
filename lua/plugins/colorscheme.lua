-- return {
-- 	"folke/tokyonight.nvim",
-- 	priority = 1000,
-- 	lazy = false,
-- 	config = function()
-- 		vim.cmd([[colorscheme tokyonight-moon]])
-- 	end,
-- 	on_colors = function(colors) end,
-- 	on_highlights = fuction(highlights, colors) end,
-- }

return {
	"EdenEast/nightfox.nvim",
	config = function()
		vim.cmd([[colorscheme duskfox]])
		vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
	end,
	options = {
		styles = { strings = "italic" },
		transparent = true,
	},
}
