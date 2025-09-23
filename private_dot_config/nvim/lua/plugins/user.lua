-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
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
        sources = {
          -- your sources for the language server
          require("schema-companion").sources.matchers.kubernetes.setup { version = "master" },
          require("schema-companion").sources.lsp.setup(),
          require("schema-companion").sources.schemas.setup {
            {
              name = "Kubernetes master",
              uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json",
            },
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
  { "CarloWood/vim-plugin-AnsiEsc" },
  {
    "johmsalas/text-case.nvim",
    config = function()
      require("textcase").setup {}
      require("telescope").load_extension "textcase"
      vim.api.nvim_set_keymap("n", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
      vim.api.nvim_set_keymap("v", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
    end,
  },
  { "akinsho/git-conflict.nvim", version = "*", config = true },

  { "rafikdraoui/jj-diffconflicts" },

  -- config overrides
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = { { "<leader>e", "<cmd>Neotree focus reveal_force_cwd<cr>", desc = "" } },
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = true,
    event = "wezterm" and "VeryLazy", -- load early if mux detected
    specs = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<<leader>-H>"] =
            { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
          maps.n["<<leader>-J>"] =
            { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
          maps.n["<<leader>-K>"] =
            { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
          maps.n["<<leader>-L>"] =
            { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
          maps.n["<<leader>-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
          maps.n["<<leader>-Down>"] =
            { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
          maps.n["<<leader>-Left>"] =
            { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
          maps.n["<<leader>-Right>"] =
            { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
        end,
      },
    },
    opts = { ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" }, ignored_buftypes = { "nofile" } },
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
  -- {
  --   "echasnovski/mini.indentscope",
  --   event = "User AstroFile",
  --   opts = {
  --     options = {
  --       border = "top",
  --       try_as_border = true,
  --     },
  --   },
  -- },
}
