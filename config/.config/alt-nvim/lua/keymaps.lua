local map = vim.keymap.set
local opts = { silent = true }

-- Save
map({ "n", "i", "v", "x" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Scroll and center
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Navigate windows
map("n", "<C-h>", "<C-w>h", { desc = "Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Right Window" })

-- Navigate buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Indent smarter
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Do not copy single char deletions to register
map("n", "x", '"_x', opts)

-- Center after search
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Clear search highlight
map("n", "<Esc>", "<cmd>noh<cr>", opts)

-- Toggle NeoTree
map("n", "<leader>e", "<cmd>Neotree reveal toggle float<cr>", { desc = "Toggle NeoTree" })

