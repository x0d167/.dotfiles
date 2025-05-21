-- Map Leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Basic options
vim.opt.autoindent = true -- Maintain current indent on new lines
vim.opt.autowrite = true -- Auto-save before commands like :next or :make
vim.opt.backspace = "indent,eol,start" -- Allow backspace over everything in insert mode
vim.opt.breakindent = true -- Preserve visual indent on wrapped lines
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard
vim.opt.cmdheight = 1 -- Command line height (more = more space for messages)
-- vim.opt.colorcolumn = "+1" -- Show a marker one column past 'textwidth' (good for soft edge)
vim.opt.compatible = false -- Disable Vi compatibility (enables full Vim features)
vim.opt.completeopt = "menu,menuone,noselect" -- Completion menu behavior (required for good completion UIs)
vim.opt.conceallevel = 2 -- Hide markdown/conceal characters, but keep substitutions visible
vim.opt.confirm = true -- Prompt to save unsaved changes before quitting
vim.opt.cursorline = true -- Highlight the current line
vim.opt.encoding = "utf-8" -- Internal string encoding (always should be UTF-8)
vim.opt.expandtab = true -- Use spaces instead of tab characters
vim.opt.fileencoding = "utf-8" -- Encoding used when writing files
vim.opt.fillchars = { -- UI characters for folds, end-of-buffer, diffs, etc.
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
vim.opt.foldlevel = 99 -- Open most folds by default
vim.opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()" -- Custom format expression for LSP
vim.opt.formatoptions = "jcroqlnt" -- Better formatting: comments, lists, auto-wrap, etc.
vim.opt.grepformat = "%f:%l:%c:%m" -- Format for grep-like output (used by :grep)
vim.opt.grepprg = "rg --vimgrep" -- Use ripgrep for :grep
vim.opt.hlsearch = true -- Highlight search results
vim.opt.ignorecase = true -- Case-insensitive search...
vim.opt.incsearch = true -- ...until capital letter or \C is used
vim.opt.mouse = "a" -- Enable mouse support in all modes
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.shiftround = true
vim.opt.shiftwidth = 4 -- Indent size when using << or >>
vim.opt.showmatch = true -- Jump to matching bracket briefly when typing
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitkeep = "cursor"
vim.opt.splitright = true -- Put new windows right of current
vim.opt.softtabstop = 4 -- Tabs feel like 4 spaces in insert mode
vim.opt.tabstop = 4 -- Display tabs as 4 spaces wide
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.textwidth = 99 -- Setting the text with for wrapping and formatting text
vim.opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
vim.opt.ttyfast = true -- Speed up screen redraw (assumes fast terminal)
vim.opt.undofile = true -- Persist undo history between sessions
vim.opt.undolevels = 10000 -- Max undo steps
vim.opt.updatetime = 200 -- Faster CursorHold and swap writes (in ms)
vim.opt.virtualedit = "block" -- Allow cursor beyond EOL in visual block mode
vim.opt.whichwrap = "bs<>[]hl" -- Let cursor wrap across lines with these keys
vim.opt.wildmode = { "longest", "list" } -- Bash-style command-line completion
vim.opt.winminwidth = 5 -- Minimum width of a split window

-- Fold handling depends on Neovim version
if vim.fn.has("nvim-0.10") == 1 then
	vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()" -- Expression for folding
	vim.opt.foldmethod = "expr" -- Use foldexpr() for folding
	vim.opt.foldtext = "" -- Use default fold text
else
	vim.opt.foldmethod = "indent" -- Fold based on indentation
	vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()" -- Custom fold display
end

-- Optional or disabled settings
-- vim.opt.backupdir = vim.fn.stdpath("cache") .. "/vim" -- Directory for backup files
-- vim.opt.spell = true                 -- Enable spell checking
-- vim.opt.swapfile = false            -- Disable swap file creation

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Syntax and filetype
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")
vim.cmd("filetype plugin on")

-- Fixing some python shenanigans
-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "python",
-- 	callback = function()
-- 		vim.bo.indentexpr = "" -- Disable Python's indent script
-- 		vim.bo.smartindent = false
-- 		vim.opt_local.shiftwidth = 4
-- 		vim.opt_local.tabstop = 4
-- 		vim.opt_local.softtabstop = 4
-- 		vim.opt_local.expandtab = true
-- 	end,
-- })

-- Transparent background
vim.cmd([[
  hi NonText ctermbg=none guibg=NONE
  hi Normal guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE
  hi SignColumn ctermbg=NONE ctermfg=NONE guibg=NONE
  hi Pmenu ctermbg=NONE ctermfg=NONE guibg=NONE
  hi FloatBorder ctermbg=NONE ctermfg=NONE guibg=NONE
  hi NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE
  hi TabLine ctermbg=NONE ctermfg=NONE guibg=NONE
  hi StatusLine guibg=NONE ctermbg=NONE guifg=#FFFFFF ctermfg=White
  hi StatusLineNC guibg=NONE ctermbg=NONE guifg=#888888 ctermfg=Gray
]])
