require 'core.options'
require 'core.keymaps'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require('lazy').setup {
  require 'plugins.neotree',
  require 'plugins.lsp',
  require 'plugins.neotree',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.bufferline',
  require 'plugins.telescope',
  require 'plugins.autocompletion',
  require 'plugins.autoformatting',
  require 'plugins.gitsigns',
  require 'plugins.alpha',
  require 'plugins.indent-blankline',
  require 'plugins.misc',
  require 'plugins.trouble',
  --  require 'plugins.neotest',
  require 'plugins.zenmode',
  require 'plugins.fugitive',
  require 'plugins.colortheme',
  require 'plugins.harpoon',
}
