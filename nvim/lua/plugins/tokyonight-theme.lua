-- Tokyo Night colorscheme
-- https://github.com/folke/tokyonight.nvim

vim.pack.add({
	"https://github.com/folke/tokyonight.nvim",
})

-- Toggle background transparency
local bg_transparent = true

local function apply()
	require("tokyonight").setup({
		style = "night",
		transparent = bg_transparent,
		styles = {
			comments = { italic = false },
			keywords = { italic = false },
			sidebars = bg_transparent and "transparent" or "dark",
			floats = bg_transparent and "transparent" or "dark",
		},
	})
	vim.cmd.colorscheme("tokyonight")
end

vim.keymap.set("n", "<leader>bg", function()
	bg_transparent = not bg_transparent
	apply()
end, { noremap = true, silent = true })

apply()
