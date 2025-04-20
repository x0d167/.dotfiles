return {
  { "echasnovski/mini.comment", event = "VeryLazy", version = false },
  {
    -- High-performance color highlighter
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup()
    end,
  },
}
