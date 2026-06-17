vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "css_beautify" },
		dockerfile = { "dockerfmt" },
		php = { "phpcbf" },
		yaml = { "yamlfix" },
		json = { "fixjson" },
		javascript = { "prettier", "eslint_d" },
		javascriptreact = { "prettier", "eslint_d" },
		typescript = { "prettier", "eslint_d" },
		typescriptreact = { "prettier", "eslint_d" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
