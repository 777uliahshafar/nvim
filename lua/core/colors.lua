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
require("kanagawa").setup {
  dimInactive = true,
  colors = {
    palette = {
      dragonWhite = "#F8F8F2",
      dragonBlack5 = "#282727",
      fujiWhite = "#F8F8F2",
      lotusInk1 = "#282727",
      lotusWhite3 = "#fbf1c7",
    },
  },
  background = { -- map the value of 'background' option to a theme
    dark = "dragon", -- try "dragon" !
    light = "lotus",
  },
  ...,
}

vim.cmd.colorscheme "gruvbox"
