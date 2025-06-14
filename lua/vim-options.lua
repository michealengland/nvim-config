vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set autoindent")
vim.cmd("set smartindent")
-- Change Leader key to space.
vim.g.mapleader = " "
-- relativenumber
vim.wo.relativenumber = true
vim.wo.number = true
-- Configure white space characters.
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
vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
-- Custom swap for tabs & spaces
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
