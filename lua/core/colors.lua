local create_cmd = vim.api.nvim_create_user_command

create_cmd("ToggleBackground", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
    vim.o.cursorline = false
  else
    vim.o.background = "dark"
    vim.o.cursorline = true
  end
end, {})

require("gruvbox").setup {
  contrast = "hard", -- can be "hard", "soft" or empty string
}

require("citruszest").setup {
  style = {
    -- This will change Constant foreground color and make it bold.
    Normal = { fg = "#f8f8f2" },
    CursorLine = { bg = "#121212" },
  },
}

require("neosolarized").setup {
  comment_italics = true,
  background_set = true,
}

vim.cmd [[colorscheme gruvbox]]
