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
  hi Pmenu guibg=#1e1e2eAA guifg=#ffffff
  hi PmenuSel guibg=#44475a guifg=#ffffff
  hi PmenuSbar guibg=#1e1e2eAA
  hi PmenuThumb guibg=#888888

  " Floating windows
  hi NormalFloat guibg=#1e1e2eAA guifg=#ffffff
  hi FloatBorder guibg=#1e1e2eAA guifg=#888888

  " Tabline fallback (if used elsewhere)
  hi TabLine guibg=#1e1e2eAA guifg=#cccccc
]])
