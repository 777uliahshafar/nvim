local create_cmd = vim.api.nvim_create_user_command

create_cmd("ToggleBackground", function()
  if vim.o.background == "dark" then
    vim.cmd "set bg=light"
  else
    vim.cmd "set bg=dark"
  end
end, {})

require("gruvbox").setup {
  palette_overrides = {
    faded_green = "#79740e",
    light0 = "#f2e5bc",
  },
}

vim.cmd [[colorscheme gruvbox]]
