return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
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

      vim.lsp.config('*', {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = { workspace = { checkThirdParty = false }, telemetry = { enable = false } },
        },
      })

      -- Ruby 3.4.4 (x86_64) headers trigger -Wdefault-const-init-field-unsafe on Xcode 26,
      -- which causes mkmf's -Werror flag checks to fail and breaks nokogiri's native extension build.
      vim.lsp.config('ruby_lsp', {
        cmd_env = {
          CFLAGS = '-Wno-default-const-init-field-unsafe',
        },
      })


      vim.lsp.enable({
        'ts_ls',
        'lua_ls',
        'ruby_lsp',
        'pyright',
        'html',
        'cssls',
        'jsonls',
        'dockerls',
        'docker_compose_language_service',
        'eslint',
      })

      -- nvim-cmp
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("copilot.suggestion").is_visible() then
              require("copilot.suggestion").accept()
            else
              fallback()
            end
          end, { "i", "s" }),
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
