local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  -- install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = true, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Transparency setup (place this towards the end)
-- vim.cmd([[
--   hi NonText ctermbg=none guibg=NONE
--   hi Normal guibg=NONE ctermbg=NONE
--   hi NormalNC guibg=NONE ctermbg=NONE
--   hi SignColumn ctermbg=NONE ctermfg=NONE guibg=NONE
--   hi Pmenu ctermbg=NONE ctermfg=NONE guibg=NONE
--   hi FloatBorder ctermbg=NONE ctermfg=NONE guibg=NONE
--   hi NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE
--   hi TabLine ctermbg=None ctermfg=None guibg=None
-- ]])
vim.cmd([[
  " Main editor background
  hi Normal guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE

  " Invisible whitespace markers
  hi NonText guibg=NONE ctermbg=NONE

  " Sign column (e.g., Git signs, diagnostics)
  hi SignColumn guibg=NONE ctermbg=NONE ctermfg=NONE

  " Pop-up menu (autocomplete, etc.)
  hi Pmenu guibg=NONE guifg=NONE
  hi PmenuSel guibg=NONE guifg=NONE
  hi PmenuSbar guibg=NONE
  hi PmenuThumb guibg=NONE

  " Floating windows
  hi NormalFloat guibg=NONE guifg=NONE
  hi FloatBorder guibg=NONE guifg=NONE

  " Tabline fallback (if used elsewhere)
  hi TabLine guibg=NONE guifg=NONE
]])

-- set highlight colors
vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
