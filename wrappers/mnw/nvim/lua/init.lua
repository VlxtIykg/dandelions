-- print("Meow :3")
Custom = {}

require("options")
require("colorscheme")
require("rebindings")
require("lsp")

-- keymaps
vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- remaps
-- clipboard
vnoremap("<leader>y", "\"+y")
nnoremap("<leader>y", "\"+y")
nnoremap("<leader>Y", "\"+Y")

inoremap("<Esc>", "<Esc>l")
nnoremap("U", "<C-r>", { desc = "Redo" })
nnoremap("<leader><leader>", "<C-^>")

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

nnoremap("J", "mzJ`z")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

nnoremap("<C-k>", "<cmd>cnext<CR>zz")
nnoremap("<C-j>", "<cmd>cprev<CR>zz")
nnoremap("<leader>k", "<cmd>lnext<CR>zz")
nnoremap("<leader>j", "<cmd>lprev<CR>zz")

-- This one is cool, it takes the word I have and put a little regex to replace all
nnoremap("<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
nnoremap("<leader>x", "<cmd>!chmod a+x %<CR>")
