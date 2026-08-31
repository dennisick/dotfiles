-- [[ Snippet Engine ]]

-- NOTE: You can also specify plugin using a version range for its git tag.
--  See `:help vim.version.range()` for more info
vim.pack.add({ { src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("2.*") } })
require("luasnip").setup({})

-- [[ Autocomplete Engine ]]
-- https://github.com/saghen/blink.cmp

vim.pack.add({ { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") } })

require("blink.cmp").setup({
	keymap = {
		-- 'default' (recommended) for mappings similar to built-in completions
		--   <c-y> to accept ([y]es) the completion.
		--    This will auto-import if your LSP supports it.
		--    This will expand snippets if the LSP sent a snippet.
		-- 'super-tab' for tab to accept
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- For an understanding of why the 'default' preset is recommended,
		-- you will need to read `:help ins-completion`
		--
		-- No, but seriously. Please read `:help ins-completion`, it is really good!
		--
		-- All presets have the following mappings:
		-- <tab>/<s-tab>: move to right/left of your snippet expansion
		-- <c-space>: Open menu or open docs if already open
		-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
		-- <c-e>: Hide menu
		-- <c-k>: Toggle signature help
		--
		-- See `:help blink-cmp-config-keymap` for defining your own keymap
		preset = "default",

		-- Accept the currently selected completion with <CR> (Enter).
		-- When the menu is not visible, <CR> falls back to its default
		-- behavior (inserting a newline). Accepting a completion also
		-- applies any additional text edits the LSP sends, which is what
		-- enables auto-imports for symbols from other modules.
		["<CR>"] = { "accept", "fallback" },

		-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
		--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
	},

	appearance = {
		-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- Adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",
	},

	completion = {
		-- By default, you may press `<c-space>` to show the documentation.
		-- Optionally, set `auto_show = true` to show the documentation after a delay.
		documentation = { auto_show = false, auto_show_delay_ms = 500 },

		menu = {
			draw = {
				-- Show the source path/namespace of each suggestion next to it.
				-- `label_description` uses `labelDetails.description` (often empty),
				-- while `source_path` (custom) falls back to `labelDetails.detail`
				-- and then `item.detail`, which is where LSPs like tsserver put
				-- the import path (e.g. `../../lib/db`).
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "kind" },
					{ "source_path" },
				},
				components = {
					source_path = {
						width = { max = 40 },
						text = function(ctx)
							local item = ctx.item
							local text = nil
							if type(item.labelDetails) == "table" then
								text = item.labelDetails.detail
							end
							if not text or text == "" then
								text = item.detail
							end
							return text or ""
						end,
						highlight = "BlinkCmpLabelDescription",
					},
				},
			},
		},
	},

	sources = {
		default = { "lsp", "path", "snippets" },
	},

	snippets = { preset = "luasnip" },

	-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
	-- which automatically downloads a prebuilt binary when enabled.
	--
	-- By default, we use the Lua implementation instead, but you may enable
	-- the rust implementation via `'prefer_rust_with_warning'`
	--
	-- See `:help blink-cmp-config-fuzzy` for more information
	fuzzy = { implementation = "lua" },

	-- Shows a signature help window while you type arguments for a function
	signature = { enabled = true },
})
