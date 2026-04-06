vim.loader.enable()

local g = vim.g
local o = vim.o

g.mapleader = " "
g.clipboard = "wl-copy"

vim.opt.matchpairs:append("<:>")
o.hidden = false
o.timeout = false

o.cursorline = true
o.cursorlineopt = "both"

o.number = true
o.relativenumber = true
o.signcolumn = "yes"

o.smoothscroll = true
o.scrolloff = 8

o.title = true
o.titlestring = vim.fn.getcwd():match("([^/]+)$") .. ": %t"

o.expandtab = true
o.tabstop = 2
o.shiftwidth = 0

o.foldenable = false
o.foldmethod = "indent"
o.shiftround = true
o.breakindent = true
o.autoindent = true
o.wrap = false


o.ignorecase = true
o.smartcase = true
o.hlsearch = false
o.incsearch = true

o.showmode = false
o.showcmd = true

o.laststatus = 3

o.splitbelow = true
o.splitright = true

o.formatoptions = "cjqr"
o.textwidth = 84
