return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = true,
  init = false,
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local v = vim.version()
    local version = " v" .. v.major .. "." .. v.minor .. "." .. v.patch
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
      dashboard.button("f", " " .. " Find file", "<cmd> lua LazyVim.pick()() <cr>"),
      dashboard.button("n", " " .. " New file", [[<cmd> ene <BAR> startinsert <cr>]]),
      dashboard.button("r", " " .. " Recent files", [[<cmd> lua LazyVim.pick("oldfiles")() <cr>]]),
      dashboard.button("g", " " .. " Find text", [[<cmd> lua LazyVim.pick("live_grep")() <cr>]]),
      dashboard.button("c", " " .. " Config", "<cmd> lua LazyVim.pick.config_files()() <cr>"),
      dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
      dashboard.button("x", " " .. " Lazy Extras", "<cmd> LazyExtras <cr>"),
      dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
      dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 8
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

    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    -- Default footer
    dashboard.section.footer.val = {
      "",
      nvim_version(),
      datetime(),
    }

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = {
          "",
          nvim_version(),
          datetime(),
          "",
          string.format("⚡ Neovim loaded %d/%d plugins in %.2fms", stats.loaded, stats.count, ms),
        }
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
