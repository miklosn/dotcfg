local opt = vim.opt
opt.wrap = true
opt.linebreak = true

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".DS_Store",
            "thumbs.db",
            "node_modules",
          },
        },
      },
    },
  },
}