return {
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      opts.config.center = {
        {
          action = "Telekasten new_note",
          desc = " New Note",
          icon = " ",
          key = "n",
        },
        {
          action = "Telekasten new_templated_note",
          desc = " New Templated Note",
          icon = " ",
          key = "t",
        },
        {
          action = LazyVim.pick("oldfiles"),
          desc = " Recent Files",
          icon = " ",
          key = "r",
        },
        {
          action = LazyVim.pick.config_files(),
          desc = " Config",
          icon = " ",
          key = "c",
        },
        {
          action = "LazyExtras",
          desc = " Lazy Extras",
          icon = " ",
          key = "x",
        },
        {
          action = "Lazy",
          desc = " Lazy",
          icon = " ",
          key = "l",
        },

        {
          action = "Mason",
          desc = " Mason",
          icon = "󰒲 ",
          key = "m",
        },
        {
          action = "qa",
          desc = " Quit",
          icon = " ",
          key = "q",
        },
      }
    end,
  },
}
