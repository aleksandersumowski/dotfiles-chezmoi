return {
  -- testing!
  { "sindrets/diffview.nvim" },
  {
    "cenk1cenk2/schema-companion.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("schema-companion").setup {
        -- if you have telescope you can register the extension
        enable_telescope = true,
        matchers = {
          require("schema-companion.matchers.kubernetes").setup { version = "master" },
        },
        schemas = {
          {
            name = "Kubernetes v1.29",
            uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.29.7-standalone-strict/all.json",
          },
        },
      }
    end,
  },
  {
    "cenk1cenk2/jq.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "grapp-dev/nui-components.nvim",
    },
  },
  {
    "ksaito422/remote-line.nvim",
    config = function() require("remote-line").setup() end,
  },
  {
    "xvzc/chezmoi.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("chezmoi").setup {} end,
  },
  {
    "johmsalas/text-case.nvim",
    init = function() require("textcase").setup {} end,
  },

  -- config overrides
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
  -- keep
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
