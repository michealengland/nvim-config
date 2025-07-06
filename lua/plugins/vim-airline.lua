return {
	"vim-airline/vim-airline",
	config = function()
		local set = vim.api.nvim_set_var

		set('airline_theme', 'base16_dracula')
		set('airline_skip_empty_sections', 1)

		set('airline_left_sep', '')
		set('airline_right_sep', '')

		set('airline#extensions#tabline#left_sep', ' ')
		set('airline#extensions#tabline#left_alt_sep', ' ')
		set('airline#extensions#tabline#enabled', 1)
		set('airline#extensions#tabline#fnamemod', ':t')
		set('airline#extensions#tabline#formatter', 'jsformatter')
	end,
	dependencies = "vim-airline/vim-airline-themes",
}
