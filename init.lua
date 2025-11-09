if vim.g.vscode == nil then
	require("commons")
	require("lazy_settings")
end
require("keymaps")

if vim.fn.has('mac') == 1 then
  vim.g.clipboard = {
    name = "pbcopy",
    copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
    paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
    cache_enabled = 0,
  }
end

vim.opt.clipboard = "unnamed,unnamedplus"
