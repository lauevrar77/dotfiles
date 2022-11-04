local nnoremap = require("levdev.keymap").nnoremap
local inoremap = require("levdev.keymap").inoremap

-- Back to normal mode
inoremap("kj", "<Esc>")

-- Panes navigation
nnoremap("<c-k>", "<cmd>wincmd k<CR>")
nnoremap("<c-j>", "<cmd>wincmd j<CR>")
nnoremap("<c-h>", "<cmd>wincmd h<CR>")
nnoremap("<c-l>", "<cmd>wincmd l<CR>")

-- Telescope
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fg","<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb","<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh","<cmd>Telescope help_tags<cr>")

-- File explorer
nnoremap("<leader>ee", "<cmd>NvimTreeToggle<cr>")

-- Terminal
nnoremap("<c-t>", "<cmd>ToggleTerm direction=vertical<CR>")
