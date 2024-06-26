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
if vim.g.vscode then
	keymap.set('n', 'tn', ':tabnext<Return>')
	keymap.set('n', 'tp', ':tabprevious<Return>')
else
	keymap.set('n', 'tn', ':bnext<CR>', { noremap = true })
	keymap.set('n', 'tp', ':bprev<CR>', { noremap = true })
end

-- move buffer
-- keymap.set('n', '<leader>b]', ':bnext<CR>', { noremap = true })
-- keymap.set('n', '<leader>b[', ':bprev<CR>', { noremap = true })
-- resize window
keymap.set('n', '+', ':resize +5<CR>', { noremap = true })
keymap.set('n', '-', ':resize -5<CR>', { noremap = true })

-- Netrw を toggle する関数を設定
-- 元処理と異なり Vex を呼び出すことで左 window に表示
vim.g.NetrwIsOpen = 0
function ToggleNetrw()
    if vim.g.NetrwIsOpen == 1 then
        for i = vim.fn.bufnr('$'), 1, -1 do
            if vim.fn.getbufvar(i, '&filetype') == 'netrw' then
                vim.cmd('silent! bwipeout ' .. i)
            end
        end
        vim.g.NetrwIsOpen = 0
    else
        vim.g.NetrwIsOpen = 1
        vim.cmd('silent! Vex')
    end
	end

-- ショートカットの設定
-- = を 2 回連続押下で toggle
vim.api.nvim_set_keymap('n', '==', ':lua ToggleNetrw()<CR>', { noremap = true, silent = true })

-- バッファの内容全体を使って Copilot とチャットする
function CopilotChatBuffer()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end

-- <leader>ccq (Copilot Chat Quick) で Copilot とチャットする
vim.api.nvim_set_keymap("n", "<leader>ccq", "<cmd>lua CopilotChatBuffer()<cr>", { noremap = true, silent = true })

-- telescope を使ってアクションプロンプトを表示する
function ShowCopilotChatActionPrompt()
  local actions = require("CopilotChat.actions")
  require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end

-- <leader>ccp (Copilot Chat Prompt の略) でアクションプロンプトを表示する
vim.api.nvim_set_keymap("n", "<leader>ccp", "<cmd>lua ShowCopilotChatActionPrompt()<cr>", { noremap = true, silent = true })

