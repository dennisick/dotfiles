-- Nord.nvim is meant to be a modern colorscheme written in lua for NeoVim that supports a lot of the new features added to NeoVim like built-in LSP and TreeSitter
-- https://github.com/shaunsingh/nord.nvim

vim.pack.add({
	"https://github.com/shaunsingh/nord.nvim",
})

vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = true
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = false

require("nord").set()

-- Toggle background transparency
local bg_transparent = true

local toggle_transparency = function()
	bg_transparent = not bg_transparent
	vim.g.nord_disable_background = bg_transparent
	vim.cmd([[colorscheme nord]])
end

vim.keymap.set("n", "<leader>bg", toggle_transparency, { noremap = true, silent = true })

vim.cmd.colorscheme("nord")
