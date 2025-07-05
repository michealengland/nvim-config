-- :JSONFormat to format current line (or visual selection) as JSON
vim.api.nvim_create_user_command(
  'JSONFormat',
  '<line1>,<line2>!jq',
  {
    range = true,
  }
)
