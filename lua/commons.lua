-- change the leader key
vim.g.mapleader = " "
-- file encording type
vim.opt.fileencoding = 'utf-8'
vim.scriptencoding = 'uff-8'
vim.opt.encoding = 'utf-8'
-- display file name
vim.opt.title = true
-- show the hightlight when search any word with //
vim.opt.hlsearch = true
-- not make swapfile
vim.opt.swapfile = false
-- not makebuckup file
--
vim.opt.backup = false
-- switching baffa not save the file
vim.opt.hidden = true
-- enfasis cursor point
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- clipbord
-- vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.laststatus = 2
vim.opt.showmatch = true
-- put the number on leftside
vim.opt.number = true
vim.opt.autoread = true
-- about indent
 vim.opt.breakindent = true
 vim.opt.autoindent = true
 vim.opt.smartindent = true
 vim.api.nvim_command('filetype plugin indent on')
-- 以下２つはautoindentとsmartindentの有効と重複するためコメントアウト
-- vim.opt.ai = true
-- vim.opt.si = true
-- about tab
vim.opt.showtabline = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.scrolloff = 10
vim.opt.cmdheight = 1
vim.opt.wildmenu = true
vim.opt.listchars = {tab='>-', trail='*', nbsp='+'}

-- transmission config
vim.opt.termguicolors = true
vim.opt.winblend = 30
vim.opt.pumblend = 30

vim.o.foldenable = false

vim.opt.splitright = true
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

local grp = vim.api.nvim_create_augroup("NetrwLayout", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = grp,
  once = true,
  callback = function(ev)
    if vim.fn.isdirectory(ev.file) ~= 1 then return end
    vim.schedule(function()
      vim.cmd("Lexplore")
      local total = vim.fn.winnr("$")
      if total == 1 then vim.cmd("vnew") end
      vim.cmd("wincmd l")
      if vim.bo.filetype == "netrw" then vim.cmd("bn") end
    end)
  end,
})

-- カレントバッファファイルのパスをクリップボードにコピーする
vim.keymap.set('n', '<Leader>fp', function()
	local filepath = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
	vim.fn.setreg('+', filepath)
	vim.api.nvim_echo({{'File path copied: ' .. filepath, 'Normal'}}, false, {})
end, { noremap = true, desc = "Copy full file path to clipboard" })

