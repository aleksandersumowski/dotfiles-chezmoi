-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
    {import = "astrocommunity.pack.clojure"},
    {import = "astrocommunity.pack.terraform"},
    {import = "astrocommunity.project.nvim-spectre"},
    {import = "astrocommunity.motion.mini-surround"},
    {import = "astrocommunity.motion.leap-nvim"},
    {import = "astrocommunity.motion.flit-nvim"}
  -- import/override with your plugins folder
}