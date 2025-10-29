-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.fuzzy-finder.telescope-nvim" },
  { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.pack.clojure" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.chezmoi" },
  { import = "astrocommunity.pack.kotlin" },
  { import = "astrocommunity.pack.helm" },
  { import = "astrocommunity.pack.jj" },
  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.search.nvim-spectre" },
  { import = "astrocommunity.motion.mini-surround" },
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.indent.mini-indentscope" },
  { import = "astrocommunity.colorscheme.nordic-nvim" },
  -- { import = "astrocommunity/code-runner/sniprun" },
  -- import/override with your plugins folder
}
