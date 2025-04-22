require("zen-mode").setup {
  window = {
    backdrop = 1,
    -- width = 0.95, -- 95\% dari lebar editor
    width = 69,
    options = {
      signcolumn = "yes",
      number = false,
      foldcolumn = "0",
      scrolloff = 999,
      list = false,
      -- cursorline = false,
      conceallevel = 3,
    },
  },
  plugins = {
    twilight = { enabled = false },
  },
}

local g = vim.g
g.limelight_default_coefficient = 0.65
