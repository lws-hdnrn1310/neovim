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
        ensure_installed = { "ts_ls", "lua_ls", "pyright", "solargraph" },
        automatic_installation = true,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local function lsp_setup(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
        })
      end

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lsp_setup(server_name)
        end,
      })

      -- `nvim-cmp` の設定
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
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- LSP の補完
          { name = "buffer" }, -- バッファ内の補完
          { name = "path" }, -- パス補完
          { name = "luasnip" }, -- スニペット補完
        }),
      })
    end,
  }
}
