return {
  "mistricky/codesnap.nvim",
  event = "VeryLazy",
  build = "make build_generator",
  keys = {
    { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
    { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
  },
  opts = {
    save_path = "~/Pictures/CodeSnap",
    has_breadcrumbs = true,
    has_line_number = true,
    bg_theme = "default",
    bg_padding = 0,
    border = "rounded",
    watermark = "x0d",
    watermark_font_family = "MesloLG",
    mac_window_bar = false,
    show_workspace = true,
  },
}
