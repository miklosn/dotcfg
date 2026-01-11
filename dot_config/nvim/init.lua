-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("telekasten").setup({
  home = vim.fn.expand("~/zk"), -- Put the name of your notes directory here
})
