local nnoremap = require("levdev.keymap").nnoremap
local inoremap = require("levdev.keymap").inoremap

-- Back to normal mode
inoremap("kj", "<Esc>")

nnoremap("<leader>pv", "<cmd>Ex<CR>")

-- Telescope
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fg","<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb","<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh","<cmd>Telescope help_tags<cr>")
