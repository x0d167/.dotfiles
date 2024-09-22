require 'core.options'
require 'core.keymaps'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

--@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require('lazy').setup {
  require 'plugins.cmp',
  require 'plugins.colortheme',
  require 'plugins.codesnap',
  require 'plugins.rustaceanvim',
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
  require 'plugins.comment',
  require 'plugins.zenmode',
  require 'plugins.fugitive',
  require 'plugins.harpoon',
  require 'plugins.neotest',
  require 'plugins.noice',
}
-- test the below and delete if you hate it
-- LSP Diagnostics Options Setup
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = '',
  })
end

sign { name = 'DiagnosticSignError', text = '' }
sign { name = 'DiagnosticSignWarn', text = '' }
sign { name = 'DiagnosticSignHint', text = '' }
sign { name = 'DiagnosticSignInfo', text = '' }

vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = false,
  float = {
    border = 'rounded',
    source = 'if_many',
    header = '',
    prefix = '',
  },
}

vim.cmd [[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]]
