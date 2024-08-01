return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = { { "<leader>e", "<cmd>Neotree focus reveal_force_cwd<cr>", desc = "" } },
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
  },
  {
    "xvzc/chezmoi.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("chezmoi").setup {
        -- your configurations
      }
    end,
  },
  { "CarloWood/vim-plugin-AnsiEsc" },
  {
    "m00qek/baleia.nvim",
    init = function() require("baleia").setup {} end,
  },
  {
    "johmsalas/text-case.nvim",
    init = function() require("textcase").setup {} end,
  },
  {
    "liouk/gitlinks.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("gitlinks").setup() end,
  },
  {
    "echasnovski/mini.indentscope",
    event = "User AstroFile",
    opts = {
      options = {
        border = "top",
        try_as_border = true,
      },
    },
  },
}
