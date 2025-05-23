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
vim.opt.clipboard:append({"unnamedplus"})
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

-- ツリー表示
-- 表示を変更したい場合は i で切替可能
vim.g.netrw_liststyle = 3
-- 上部のバナーを非表示
-- I で toggle 可能
vim.g.netrw_banner = 0
-- window サイズ
vim.g.netrw_winsize = 25
-- Netrw で Enter 押下時の挙動設定
vim.g.netrw_browse_split = 3
vim.g.netrw_altv = 1
if vim.g.vscode then
	vim.opt.clipboard:append('unnamedplus')
end

-- カレントバッファファイルのパスをクリップボードにコピーする
vim.keymap.set('n', '<Leader>fp', function()
	local filepath = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':.')
	vim.fn.setreg('+', filepath)
	vim.api.nvim_echo({{'File path copied: ' .. filepath, 'Normal'}}, false, {})
end, { noremap = true, desc = "Copy full file path to clipboard" })

