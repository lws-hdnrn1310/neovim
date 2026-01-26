return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        header = {
          " ███╗  ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗  ███╗ ",
          " ██╔██╗ ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
          " ██║╚██╗██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
          " ██║ ╚████║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
          " ██║  ╚═══╝███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
          " ╚═╝      ╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        },
        shortcut = {
            { icon = "  ", desc = "Find File",  key = "f", action = "Telescope find_files" },
            { icon = "  ", desc = "New File",   key = "n", action = "enew" },
            { icon = "  ", desc = "Recent",     key = "r", action = "Telescope oldfiles" },
            { icon = "  ", desc = "Find Text",  key = "g", action = "Telescope live_grep" },
            { icon = "  ", desc = "Config",     key = "c", action = "Telescope find_files cwd=~/.config/nvim" },
            { icon = "  ", desc = "Quit",       key = "q", action = "qa" },
          },
        footer = { 'Welcome to Neovim' },
      },
    }
  end,
  dependencies = { 'nvim-tree/nvim-web-devicons' }
}

