--return {
--  {
--    --   "Yazeed1s/minimal.nvim",
--    "folke/tokyonight.nvim",
--  },
--  {
--    "LazyVim/LazyVim",
--    opts = {
--      colorscheme = "tokyonight",
--    },
--  },
--}
--
--

return {
  {
    "aliqyan-21/darkvoid.nvim",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = false,
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm", -- storm, moon, night, day
      transparent = false,
    },
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        transparent = false,
      },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "moon", -- auto, main, moon, or dawn
      dark_variant = "moon",
      dim_inactive_windows = false,
      extend_background_behind_borders = true,
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      transparent_mode = false,
      contrast = "hard", -- can be "hard", "soft" or empty string
    },
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          transparent = false,
        },
      })
    end,
  },
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
    },
  },
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
    },
  },
  {
    "rktjmp/lush.nvim",
    -- if you wish to use your own colorscheme:
    -- { dir = '/absolute/path/to/colorscheme', lazy = true },
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    -- Add in any other configuration;
    --   event = foo,
    --   config = bar
    --   end,
  },
  { "nvim-mini/mini.base16", version = false },
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      -- custom options here
    },
    config = function(_, opts)
      require("tokyodark").setup(opts) -- calling setup is optional
    end,
  },
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.sonokai_style = "andromeda" -- default, atlantis, andromeda, shusia, maia, espresso
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_transparent_background = 0
    end,
  },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_bg = false,
    },
  },
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "multiplex", -- "vulgaris" (default), "multiplex", "light"
      transparent = false,
    },
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    opts = {
      options = {
        transparency = false,
      },
    },
  },
  {
    "marko-cerovac/material.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.material_style = "deep ocean" -- darker, lighter, oceanic, palenight, deep ocean
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "sorbet", -- Change this to any of the added colorschemes
    },
  },
}
