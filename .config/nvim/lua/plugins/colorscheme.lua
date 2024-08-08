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
      transparent_background = true,
    },
  },
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = false, opts = ... },
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
