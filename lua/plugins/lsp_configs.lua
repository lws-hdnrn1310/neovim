return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      -- mason / mason-lspconfig 初期化（v2.x）
      require("mason").setup()
      local mlsp = require("mason-lspconfig")
      mlsp.setup({
        ensure_installed = {
          -- ※ lspconfig のサーバー名で。古い lspconfig なら tsserver を使う
          "ts_ls",
          "lua_ls",
          "ruby_lsp",
          "pyright",
          "html",
          "cssls",
          "jsonls",
          "dockerls",
          "docker_compose_language_service",
          "eslint",
        },
        automatic_installation = true,
      })

      -- 共通
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      local on_attach = function(client, bufnr)
        local o = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, o)
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, o)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, o)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, o)
        vim.keymap.set('n', 'K',  vim.lsp.buf.hover, o)
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, o)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, o)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, o)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
      end

      -- サーバー毎の最終セットアップ
      local lspconfig = require("lspconfig")        -- これは残してOK（読むだけ）
      local configs   = require("lspconfig.configs")-- ← 追加

      local function setup_server(name)
        -- 古い環境向けフォールバック（ts_ls が無い場合は tsserver を使う）
        if name == "ts_ls" and not configs.ts_ls then
          name = "tsserver"
        end

        local cfg = configs[name]
        if not cfg then
          vim.schedule(function()
            vim.notify(("lspconfig: unknown server '%s'"):format(name), vim.log.levels.WARN)
          end)
          return
        end

        local opts = { capabilities = capabilities, on_attach = on_attach }
        if name == "lua_ls" then
          opts.settings = {
            Lua = { workspace = { checkThirdParty = false }, telemetry = { enable = false } },
          }
        end

        cfg.setup(opts)                             -- ← configs 経由で setup（警告が出ない）
      end

      -- v2.x では setup_handlers は廃止：インストール済みを回す
      for _, server in ipairs(mlsp.get_installed_servers()) do
        setup_server(server)
      end

      -- nvim-cmp（そのまま）
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"]   = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"]    = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
        }),
      })
    end,
  }
}
