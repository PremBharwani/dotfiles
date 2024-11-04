return {
	'MeanderingProgrammer/render-markdown.nvim',
	dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig


	-- For any customizations refer to the wiki : [https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki]

	config = function()
		require('render-markdown').setup({
		    
			file_types = { 'markdown' }, -- filetype this plugin will run on 
			enabled = true,
			-- render_modes = true,
    			heading = {
    			    width = 'block',
    			    left_pad = 2,
    			    right_pad = 4,
    			},
			anti_conceal = {
			        enabled = true,
			        -- Which elements to always show, ignoring anti conceal behavior. Values can either be booleans
			        -- to fix the behavior or string lists representing modes where anti conceal behavior will be
			        -- ignored. Possible keys are:
			        --  head_icon, head_background, head_border, code_language, code_background, code_border
			        --  dash, bullet, check_icon, check_scope, quote, table_border, callout, link, sign
			        ignore = {
			            code_background = true,
			            sign = true,
			        },
			        above = 1,
			        below = 1,
			    },
		})
	end,	
	lazy = false, 
}
