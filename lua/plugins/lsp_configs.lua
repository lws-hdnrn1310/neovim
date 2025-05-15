return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp", -- 自動補完プラグイン
      "hrsh7th/cmp-nvim-lsp", -- LSP の補完を nvim-cmp に統合
      "hrsh7th/cmp-buffer", -- バッファ内の補完
      "hrsh7th/cmp-path", -- パス補完
      "L3MON4D3/LuaSnip", -- スニペット補完
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "lua_ls",
          "ruby_lsp",
          "pyright",
          "html",
          "cssls",
          "jsonls",
          "docker_compose_language_service",
          "dockerls",
          "eslint",
        },
        automatic_installation = true,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSPサーバーがバッファにアタッチされたときに呼び出される関数
      local on_attach = function(client, bufnr)
        -- バッファローカルなキーマッピングを設定します
        -- これにより、LSPが起動しているバッファでのみこれらのキーマップが有効になります
        local bufopts = { noremap=true, silent=true, buffer=bufnr }

        -- 定義元へジャンプ
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        -- 型定義へジャンプ
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
        -- 実装へジャンプ (インターフェースなどがある場合)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        -- 参照元を検索
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        -- ホバー情報表示
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        -- シグネチャヘルプ表示
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        -- 名前変更
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        -- コードアクション
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        -- 診断メッセージを次へ移動
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
        -- 診断メッセージを前へ移動
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
        -- カーソル下の診断メッセージを表示
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
        -- (オプション) ドキュメントフォーマット
        -- vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)

        -- (おまけ) ドキュメントハイライトを有効化 (一部のサーバーのみサポート)
        if client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = bufnr,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = bufnr,
                callback = vim.lsp.buf.clear_references,
            })
        end

        -- (おまけ) インレイヒントを有効化 (nvim-lspconfigの最新版が必要)
        -- vim.lsp.inlay_hint(bufnr, true)
      end

      local function lsp_setup(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          -- ここに on_attach コールバックを追加
          on_attach = on_attach,
          -- 必要に応じて、サーバーごとの追加設定をここに追加します
          -- 例えば、lua_ls の設定:
          -- [[
          -- settings = {
          --   Lua = {
          --     workspace = { checkThirdParty = false },
          --     telemetry = { enable = false },
          --     -- Add any additional lua_ls settings here
          --   },
          -- },
          -- ]]
          -- 他のサーバーの設定も同様に追加できます
          -- 例えば、ts_ls の設定:
          -- [[
          -- init_options = {
          --   hostInfo = "neovim",
          -- },
          -- ]]
        })
      end

      require("mason-lspconfig").setup_handlers({
        -- インストールされているすべてのLSPサーバーに対して、デフォルトのセットアップハンドラとして lsp_setup 関数を適用
        function(server_name)
          lsp_setup(server_name)
        end,
        -- もし特定のサーバーに特別な設定が必要な場合は、以下のように上書きできます
        -- 例如:
        -- ["lua_ls"] = function()
        --   require("lspconfig").lua_ls.setup({
        --     on_attach = on_attach,
        --     settings = {
        --       Lua = {
        --         workspace = { checkThirdParty = false },
        --         telemetry = { enable = false },
        --       },
        --     },
        --   })
        -- end,
        -- ["ts_ls"] = function()
        --   require("lspconfig").ts_ls.setup({
        --     on_attach = on_attach,
        --     init_options = {
        --       hostInfo = "neovim",
        --     },
        --   })
        -- end,
      })

      -- `nvim-cmp` の設定 (既存のまま)
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -- 補完ウィンドウ表示中にドキュメントウィンドウを開く例
          -- ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select = false` to only confirm explicitly selected items.
          -- ["<C-Space>"] = cmp.mapping.complete(), -- manual completion
          -- ["<C-e>"] = cmp.mapping.abort(), -- dismiss completion
          -- ["<C-n>"] = cmp.mapping.scroll_docs(4), -- scroll down docs
          -- ["<C-p>"] = cmp.mapping.scroll_docs(-4), -- scroll up docs
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- LSP の補完
          { name = "buffer" }, -- バッファ内の補完
          { name = "path" }, -- パス補完
          { name = "luasnip" }, -- スニペット補完
        }),
        -- 補完メニューの外観設定例
        -- formatting = {
        --   format = require('lspkind').cmp_format({
        --     maxwidth = 50,
        --     ellipsis_char = '...',
        --   })
        -- },
        -- window = {
        --   completion = cmp.config.window.bordered(),
        --   documentation = cmp.config.window.bordered(),
        -- },
      })

      -- LuaSnip の設定例 (必要であれば)
      -- require("luasnip.loaders.from_vscode").lazy_load()
      -- vim.keymap.set({"i","s"}, "<C-Tab>", function() require("luasnip").jump(1) end, {silent = true})
      -- vim.keymap.set({"i","s"}, "<C-S-Tab>", function() require("luasnip").jump(-1) end, {silent = true})
    end,
  }
}
