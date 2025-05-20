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
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    opts = {
      indent = {
        char = "│",
        highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowGreen",
          "RainbowCyan",
          "RainbowViolet",
          "RainbowOrange",
        },
      },
      scope = { enabled = false }, -- optional: disables active indent scope highlight
    },
  },
}
