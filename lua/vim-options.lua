vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set autoindent")
vim.cmd("set smartindent")
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
vim.api.nvim_set_keymap('n', '<leader>tt', ':lua ToggleTabsToSpaces()<CR>', { noremap = true, silent = true })
-- relativenumber
vim.wo.relativenumber = true
vim.wo.number = true
-- Configure white space characters.
vim.cmd [[
  highlight SpecialKey ctermfg=Black guifg=#6272a4
  highlight NonText ctermfg=Black guifg=#6272a4
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
-- Clone file to current location.
vim.api.nvim_create_user_command("Clone", function(opts)
    local current_dir = vim.fn.expand("%:h")  -- Get current file's directory
    local new_path = current_dir .. "/" .. opts.args
    vim.cmd("write " .. new_path)  -- Save to new filename in the same directory
end, { nargs = 1 })  -- Requires one argument
