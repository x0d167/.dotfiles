-- Additional editor extras (git, terminal, surround, cmp)
return {
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {
			modes = {
				lsp = { win = { position = "right" } },
			},
		},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
			{ "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP References (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					local trouble = require("trouble")
					if trouble.is_open() then
						trouble.prev({ skip_groups = true, jump = true })
					else
						pcall(vim.cmd.cprev)
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					local trouble = require("trouble")
					if trouble.is_open() then
						trouble.next({ skip_groups = true, jump = true })
					else
						pcall(vim.cmd.cnext)
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
	},

	{
		"echasnovski/mini.surround",
		event = "VeryLazy",
		opts = {
			mappings = {
				add = "gsa",
				delete = "gsd",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "gsr",
				update_n_lines = "gsn",
			},
		},
	},

	{
		"saghen/blink.cmp",
		version = "*",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		opts = {
			snippets = {
				expand = function(snippet)
					vim.fn["vsnip#anonymous"](snippet)
				end,
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				accept = {
					auto_brackets = { enabled = true },
				},
				ghost_text = { enabled = false },
			},
			signature = { enabled = true },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			keymap = {
				preset = "super-tab",
				["<C-y>"] = { "select_and_accept" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		config = function(_, opts)
			require("blink.cmp").setup(opts)
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "~" },
			},
			signs_staged = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "~" },
			},
		},
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<C-t>]],
				direction = "float",
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				close_on_exit = true,
				persist_size = false,
				shell = vim.o.shell,
				float_opts = {
					border = "curved",
					winblend = 0,
					highlights = {
						Normal = { guibg = "#1e1e2eAA" },
						NormalFloat = { link = "Normal" },
						border = "Normal",
					},
				},
			})
		end,
	},
} -- END extras
