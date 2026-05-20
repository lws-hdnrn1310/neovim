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
      require("mason").setup()

      -- 共通
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.offsetEncoding = { "utf-16" }
      capabilities.general = {
        positionEncodings = { "utf-16" }
      }

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

      -- Neovim 0.11+ の新しい LSP 設定 API
      -- '*' で全サーバー共通の設定を適用
      vim.lsp.config('*', {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- サーバー個別設定
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = { workspace = { checkThirdParty = false }, telemetry = { enable = false } },
        },
      })

      vim.lsp.config('ruby_lsp', {
        cmd = { "yarn", "docker-compose", "exec", "api", "bash", "ruby-lsp-raw" },
        capabilities = vim.tbl_deep_extend("force", capabilities, {
          offsetEncoding = { "utf-16" },
          general = { positionEncodings = { "utf-16" } },
        }),
      })

      -- mason-lspconfig: インストールと自動有効化
      require("mason-lspconfig").setup({
        ensure_installed = {
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
        automatic_enable = true,
      })

      -- nvim-cmp
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
