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

require("citruszest").setup {
  style = {
    -- This will change Constant foreground color and make it bold.
    Normal = { fg = "#F8F8F2" },
  },
}

vim.cmd [[colorscheme gruvbox]]
