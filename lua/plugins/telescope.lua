return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = { 'node_modules', '.git', 'vendor' },
        layout_config = {
          prompt_position = 'top',
        },
      },
      pickers = {
        find_files = {
          theme = 'ivy',
        },
      },
      extensions = {
        fzf = {},
      },
    }
    vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files)
    vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep)
    vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers)
    vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags)
  end
}
