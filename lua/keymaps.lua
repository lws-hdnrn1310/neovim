local keymap = vim.keymap
-- when insert mode, change to normal mode with jj
keymap.set('i', 'jj', '<ESC>', { noremap = true })
keymap.set('v', 'v', '$h', { noremap = true })
-- move window with 
keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })
keymap.set('n', 'sh', '<C-w>h', { noremap = true })
keymap.set('n', 'sj', '<C-w>j', { noremap = true })
keymap.set('n', 'sk', '<C-w>k', { noremap = true })
keymap.set('n', 'sl', '<C-w>l', { noremap = true })
--split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
keymap.set('n', '<ESC>', ':nohlsearch<CR>')
-- new tab
keymap.set('n', 'te', ':tabedit<Return>')
-- move tab
keymap.set('n', 'tn', ':tabnext<CR>', { noremap = true })
keymap.set('n', 'tp', ':tabprev<CR>', { noremap = true })
-- move buffer
keymap.set('n', '<leader>bn', ':bnext<CR>', { noremap = true })
keymap.set('n', '<leader>bp', ':bprev<CR>', { noremap = true })
