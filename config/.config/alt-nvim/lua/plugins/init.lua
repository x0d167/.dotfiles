return {
	-- Plugin manager
	{ "folke/lazy.nvim", version = false },

	-- Treesitter for syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "python", "lua", "vim", "bash", "json", "rust", "regex", "toml" },
			highlight = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	-- Mason for installing LSPs and tools
	{
		"mason-org/mason.nvim",
        build = function()
            vim.cmd("MasonUpdate")
        end,
		config = function()
			require("mason").setup()
		end,
	},

	-- LSP config + Mason integration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
            vim.g.mason_use_system_curl = true
			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"jsonls",
					"lua_ls",
					"ruff",
					"pylsp",
				},
				automatic_enable = true,
			})

			local lspconfig = require("lspconfig")

			-- Ruff LSP: fast linter/formatter/code actions
			lspconfig.ruff.setup({
				commands = {
					RuffAutofix = {
						function()
							vim.lsp.buf.execute({
								command = "ruff.applyAutofix",
								arguments = {
									{ uri = vim.uri_from_bufnr(0) },
								},
							})
						end,
						description = "Ruff: Fix all auto-fixable problems",
					},
					RuffOrganizeImports = {
						function()
							vim.lsp.buf.execute({
								command = "ruff.applyOrganizeImports",
								arguments = {
									{ uri = vim.uri_from_bufnr(0) },
								},
							})
						end,
						description = "Ruff: Organize imports",
					},
				},
			})

			-- Pylsp: disable overlapping linters/formatters
			lspconfig.pylsp.setup({
				settings = {
					pylsp = {
						plugins = {
							pyflakes = { enabled = false },
							pycodestyle = { enabled = false },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							mccabe = { enabled = false },
							pylsp_mypy = { enabled = false },
							pylsp_black = { enabled = false },
							pylsp_isort = { enabled = false },
						},
					},
				},
			})

			-- Bash
			lspconfig.bashls.setup({})
			-- JSON
			lspconfig.jsonls.setup({})
			-- Lua (Neovim config)
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			})
		end,
	},

	-- For when you just can't remember the keys.
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- optional but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				popup_border_style = "rounded",
			})
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		priority = 1000,
		config = function()
			require("github-theme").setup({
				options = {
					transparent = true, -- if you want transparency like before
				},
			})
			vim.cmd("colorscheme github_dark_default")

			-- Reapply transparency and statusline highlights
			vim.cmd([[
          hi Normal guibg=NONE ctermbg=NONE
          hi NormalNC guibg=NONE ctermbg=NONE
          hi SignColumn guibg=NONE ctermbg=NONE
          hi VertSplit guibg=NONE ctermbg=NONE
          hi Pmenu guibg=NONE ctermbg=NONE
          hi PmenuSel guibg=NONE ctermbg=NONE
          hi FloatBorder guibg=NONE ctermbg=NONE
          hi NormalFloat guibg=NONE ctermbg=NONE
          hi TabLineFill guibg=NONE ctermbg=NONE
          hi StatusLine guibg=NONE ctermbg=NONE guifg=#FFFFFF ctermfg=White
          hi StatusLineNC guibg=NONE ctermbg=NONE guifg=#888888 ctermfg=Gray
        ]])
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		vscode = true,
		---@type Flash.Config
		opts = {},
      -- stylua: ignore
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      },
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
    {
        -- High performance colorizer
        "norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
        config = function()
            require("colorizer").setup({
                "*", -- Enable all filetypes
            }, {
                names = true, -- Keep color names like 'cyan' and 'maroon'
            })

            -- Auto-attach to every buffer
            vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
                callback = function()
                    require("colorizer").attach_to_buffer(0)
                end,
            })
        end,
    },
    {
        "ibhagwan/fzf-lua",
        cmd = "FzfLua",
        event = "VeryLazy",
        config = function()
            require("fzf-lua").setup({
            winopts = {
                height = 0.85,
                width = 0.85,
                row = 0.5,
                col = 0.5,
                preview = {
                layout = "horizontal", -- Ensures preview is beside results
                horizontal = "right:65%", -- 65% width for preview pane
                scrollchars = { "┃", "" },
                },
            },
            fzf_opts = {
                ["--no-scrollbar"] = true,
            },
            files = {
                prompt = "Files❯ ",
                cwd_prompt = false,
            },
            grep = {
                prompt = "Grep❯ ",
            },
            })
        end,
        keys = {
            { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
            { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files" },
            { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
            { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
            { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Git Status" },
            { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
            { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document Symbols" },
        },
    },
}
