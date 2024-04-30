return {
    -- プラグインのパスと初期設定
    "akinsho/toggleterm.nvim",
    config = function()
        -- toggleterm の設定
        require("toggleterm").setup({
            -- direction = "float", -- デフォルトの方向を設定 (コメントアウトされている場合はデフォルトの挙動)
        })

        -- キーマップ設定
        vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })
        vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { noremap = true, silent = true })

        -- lazygit ターミナルの設定
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            direction = "float",
            hidden = true,
        })

        -- lazygit トグル関数
        local function _lazygit_toggle()
            lazygit:toggle()
        end
        vim.keymap.set("n", "<leader>gt", _lazygit_toggle, { noremap = true, silent = true })
    end
}
