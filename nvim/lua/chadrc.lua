-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "gatekeeper",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

-- adding to control the color of the comments
vim.api.nvim_set_hl(0, "Comment", { fg = "#7d90a1"})
vim.api.nvim_set_hl(0, "@comment", { link = "Comment"})
-- done adding --

return M
