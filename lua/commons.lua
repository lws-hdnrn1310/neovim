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
-- vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 10
vim.opt.cmdheight = 1
vim.opt.wildmenu = true
vim.opt.listchars = {tab='>-', trail='*', nbsp='+'}

-- transmission config
vim.opt.termguicolors = true
vim.opt.winblend = 30
vim.opt.pumblend = 30

vim.o.foldenable = false
