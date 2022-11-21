-- vim.cmd("colorscheme nightfly")
-- the above line will allow us to run vim script within lua
-- but we want to do this in a protected way in case the color scheme is not installed
-- so instead of doing this we are going to do:
local status, _ = pcall(vim.cmd, "colorscheme nightfly") -- using protected call here
if not status then
	print("Colorscheme not found!") -- print error if colorscheme not installed
	return
end
