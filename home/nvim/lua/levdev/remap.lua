local nnoremap = require("levdev.keymap").nnoremap
local inoremap = require("levdev.keymap").inoremap

-- Back to normal mode
inoremap("kj", "<Esc>")

-- Telescope
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fg","<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb","<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh","<cmd>Telescope help_tags<cr>")

-- File explorer
nnoremap("<leader>ee", "<cmd>NvimTreeToggle<cr>")
