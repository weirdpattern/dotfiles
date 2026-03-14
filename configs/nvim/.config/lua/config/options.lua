vim.g.snacks_animate = false
vim.g.lazyvim_picker = "fzf"
vim.g.lazyvim_eslint_auto_format = true

if vim.fn.has("win32") then
  LazyVim.terminal.setup("pwsh")
end
