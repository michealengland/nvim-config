vim.cmd("set autoindent")
vim.cmd("set expandtab")
vim.cmd("set shiftwidth=2")
vim.cmd("set smartindent")
vim.cmd("set softtabstop=2")
vim.cmd("set tabstop=2")

-- Change Leader key to space.
vim.g.mapleader = " "

-- Relative Numbers.
vim.wo.number = true
vim.wo.relativenumber = true

-- Display white space such as tabs, spaces characters.
-- Based on https://www.manjotbal.ca/blog/neovim-whitespace.html
-- ASCII Symbol Picker https://symbl.cc/en/002E/
-- See Available Colors `:h cterm-colors`
vim.cmd([[
  highlight SpecialKey ctermfg=Black guifg=#6272a4
  highlight NonText ctermfg=Black guifg=#6272a4
]])
vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "LightRed" })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = [[
    syntax clear TrailingWhitespace |
    syntax match TrailingWhitespace "\_s\+$"
  ]],
})
vim.o.list = true
vim.o.listchars = "tab: →,lead:.,trail:."
vim.g.background = "light"
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false

-- Navigate vim panes with motions.
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Hide current search.
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Toggle between tabs & spaces.
function ToggleTabsToSpaces()
  if vim.o.expandtab then
    vim.o.expandtab = false
    print("Switched to Tabs")
  else
    vim.o.expandtab = true
    print("Switched to Spaces")
  end
end

vim.api.nvim_set_keymap("n", "<leader>tt", ":lua ToggleTabsToSpaces()<CR>", { noremap = true, silent = true })
