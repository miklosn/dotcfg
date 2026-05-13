return {
  -- Tokyo Night (default)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
    },
  },

  -- Ayu
  { "Shatur/neovim-ayu", name = "ayu", lazy = true, opts = { mirage = false } },

  -- Rose Pine
  { "rose-pine/neovim", name = "rose-pine", lazy = true, opts = { variant = "main" } },

  -- Catppuccin
  { "catppuccin/nvim", name = "catppuccin", lazy = true, opts = { flavour = "mocha" } },

  -- Kanagawa
  { "rebelot/kanagawa.nvim", lazy = true, opts = { theme = "wave" } },

  -- Gruvbox Material
  { "sainnhe/gruvbox-material", lazy = true },

  -- Everforest (Lua port)
  { "neanias/everforest-nvim", name = "everforest", lazy = true },

  -- Sonokai
  { "sainnhe/sonokai", lazy = true },

  -- Nord (Lua-native, actively maintained)
  { "gbprod/nord.nvim", lazy = true },

  -- One Dark
  { "navarasu/onedark.nvim", lazy = true, opts = { style = "dark" } },

  -- Nightfox (includes nightfox, duskfox, nordfox, carbonfox)
  { "EdenEast/nightfox.nvim", lazy = true },

  -- Dracula
  { "Mofiqul/dracula.nvim", lazy = true },

  -- GitHub Dark
  { "projekt0n/github-nvim-theme", lazy = true },

  -- Oxocarbon
  { "nyoom-engineering/oxocarbon.nvim", lazy = true },

  -- Midnight (VS Code inspired)
  { "dasupradyumna/midnight.nvim", lazy = true },

  -- Material
  { "marko-cerovac/material.nvim", lazy = true, opts = { style = "deep ocean" } },

  -- Bamboo
  { "ribru17/bamboo.nvim", lazy = true },

  -- Cyberdream
  { "scottmckendry/cyberdream.nvim", lazy = true },

  -- Modus (Emacs-inspired, high contrast)
  { "miikanissi/modus-themes.nvim", lazy = true },

  -- Solarized Osaka (modern solarized by craftzdog)
  { "craftzdog/solarized-osaka.nvim", lazy = true },

  -- Nordic (warmer Nord variant)
  { "AlexvZyl/nordic.nvim", lazy = true },

  -- Set default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nordic",
    },
  },
}
