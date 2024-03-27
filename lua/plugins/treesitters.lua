return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
		config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "awk", "bash", "comment", "css", "csv", "diff", "dockerfile", "fish", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "html", "http", "javascript", "jq", "json", "json5", "jsonc", "lua", "luadoc", "luap", "luau", "markdown", "query", "ruby", "scss", "sql", "ssh_config", "toml", "tsv", "tsx", "typescript", "vim", "vimdoc", "xml", "yaml", "embedded_template" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = false },  
        })
    end
 }
