local create_cmd = vim.api.nvim_create_user_command

create_cmd("ToggleBackground", function()
  if vim.o.background == "light" then
    vim.o.background = "dark"
    -- vim.o.cursorline = false
  else
    vim.o.background = "light"
    -- vim.o.cursorline = true
  end
end, {})

require("gruvbox").setup {
  contrast = "hard", -- can be "hard", "soft" or empty string
  overrides = {
    FlashMatch = { fg = "#00dfff", bold = true },
    FlashLabel = { fg = "#2b8db3", bold = true },
  },
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
      -- dragonWhite = "#E0E0E0",
      -- dragonBlack5 = "#e4e4e4",
      -- fujiWhite = "#F8F8F2",
      lotusInk1 = "#32302f",
      -- lotusWhite3 = "#fbf1c7",
    },
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
        },
      },
    },
  },
  overrides = function(colors)
    return {
      -- Assign a static color to strings
      markdownUrl = { link = "Function" },
      TelescopeResultsBorder = { link = "TelescopePromptBorder" },
      TelescopePreviewBorder = { link = "TelescopePromptBorder" },
      ["@markup.heading"] = { link = "Operator" },
      FlashMatch = { fg = "#00dfff", bold = true },
      FlashLabel = { fg = "#2b8db3", bold = true },
    }
  end,
  background = { -- map the value of 'background' option to a theme
    dark = "dragon", -- try "dragon" !
    light = "lotus",
  },
  ...,
}

vim.cmd.colorscheme "gruvbox"
vim.o.background = "light"
