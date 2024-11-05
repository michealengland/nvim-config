vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
-- relativenumber
vim.wo.relativenumber = true
vim.wo.number = true
-- Configure white space characters.
vim.api.nvim_set_keymap('n', '<leader>tt', ':lua ToggleTabsSpaces()<CR>', { noremap = true, silent = true })
vim.cmd [[
  highlight SpecialKey ctermfg=Black guifg=#0099cc
  highlight NonText ctermfg=Black guifg=#0099cc
]]
vim.api.nvim_set_hl(0, 'TrailingWhitespace', { bg='LightRed' })
vim.api.nvim_create_autocmd('BufEnter', {
	pattern = '*',
	command = [[
		syntax clear TrailingWhitespace |
		syntax match TrailingWhitespace "\_s\+$"
	]]}
)
vim.o.list = true
vim.o.listchars = "tab: →,lead:.,trail:."

-- Unsure.
vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')