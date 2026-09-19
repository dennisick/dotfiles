-- Pinned: upstream 4217ed8 requires herdr-agents.status but never committed the file
vim.pack.add({
  { src = "https://github.com/ctbaum/herdr-agents.nvim", version = "ed5774360f61a6de155657769d7d84a32037972f" },
})

require("herdr-agents").setup({
  claude = {
    enabled = true,
    opts = { diff_opts = { layout = "vertical" } },
  },
  codex = {
    enabled = false,
    opts = { focus_after_send = false },
  },
  review = {
    enabled = false,
    opts = { clear_after_submit = true, snippet_lines = 5 },
  },
})
