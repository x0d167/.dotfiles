return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")

    local logo = [[
        ██╗  ██╗ ██████╗ ██████╗  ██╗ ██████╗ ███████╗ ██████╗██╗  ██╗ ██████╗ 
        ╚██╗██╔╝██╔═████╗██╔══██╗███║██╔═══██╗██╔════╝██╔════╝██║  ██║██╔═══██╗
         ╚███╔╝ ██║██╔██║██║  ██║╚██║██║██╗██║█████╗  ██║     ███████║██║   ██║
         ██╔██╗ ████╔╝██║██║  ██║ ██║██║██║██║██╔══╝  ██║     ██╔══██║██║   ██║
        ██╔╝ ██╗╚██████╔╝██████╔╝ ██║╚█║████╔╝███████╗╚██████╗██║  ██║╚██████╔╝
        ╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ╚═╝ ╚╝╚═══╝ ╚══════╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝ 
    ]]

    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.buttons.val = {
      dashboard.button("f", " Find file", "<cmd>FzfLua files<cr>"),
      dashboard.button("n", " New file", "<cmd>ene<cr>"),
      dashboard.button("r", " Recent files", "<cmd>FzfLua oldfiles<cr>"),
      dashboard.button("g", " Grep text", "<cmd>FzfLua live_grep<cr>"),
      dashboard.button("c", " Config", "<cmd>FzfLua files cwd=" .. vim.fn.stdpath("config") .. "<cr>"),
      dashboard.button("l", "󰒲 Lazy", "<cmd>Lazy<cr>"),
      dashboard.button("q", " Quit", "<cmd>qa<cr>"),
    }

    -- Layout padding
    dashboard.config.layout = {
      { type = "padding", val = 5 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 8 },
      dashboard.section.footer,
    }

    return dashboard
  end,
  config = function(_, dashboard)
    local function datetime()
      return os.date("📅 %A, %B %d, %Y  🕒 %I:%M %p")
    end

    local function nvim_version()
      local v = vim.version()
      return string.format("⚙️  Neovim v%d.%d.%d", v.major, v.minor, v.patch)
    end

    dashboard.section.footer.val = {
      "",
      nvim_version(),
      datetime(),
    }

    require("alpha").setup(dashboard.opts)
  end,
}
