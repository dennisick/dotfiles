vim.pack.add({ "https://github.com/xTacobaco/cursor-agent.nvim" })

-- Toggle the interactive terminal
vim.keymap.set("n", "<leader>ca", ":CursorAgent<CR>", { desc = "Cursor Agent: Toggle terminal" })

-- Ask about the visual selection
vim.keymap.set("v", "<leader>ca", ":CursorAgentSelection<CR>", { desc = "Cursor Agent: Send selection" })

-- Ask about the current buffer
vim.keymap.set("n", "<leader>cA", ":CursorAgentBuffer<CR>", { desc = "Cursor Agent: Send buffer" })

require("cursor-agent").setup({
  -- Executable or argv table. Example "cursor-agent" {"/usr/local/bin/cursor-agent"}
  cmd = "cursor-agent",
  -- Additonal arguments always passed to the CLI
  args = {}
})


