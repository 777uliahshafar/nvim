local create_cmd = vim.api.nvim_create_user_command

create_cmd("ToggleBackground", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, {})

require("gruvbox").setup {
  contrast = "hard", -- can be "hard", "soft" or empty string
}

vim.cmd [[colorscheme gruvbox]]
