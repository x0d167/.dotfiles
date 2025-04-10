return {
  "mistricky/codesnap.nvim",
  event = "VeryLazy",
  build = "make",
  keys = {
    { "<leader>cy", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
    { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
  },
  opts = {
    save_path = "~/Pictures/CodeSnap",
    has_breadcrumbs = false,
    has_line_number = false,
    bg_theme = "summer",
    bg_padding = 0,
    border = "rounded",
    watermark = "x0d1",
    watermark_font_family = "MesloLG",
    mac_window_bar = false,
    show_workspace = false,
  },
}
