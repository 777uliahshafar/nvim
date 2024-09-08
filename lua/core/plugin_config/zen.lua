require("zen-mode").setup {
  window = {
    backdrop = 1,
    width = 62,
    options = {
      signcolumn = "no",
      number = false,
      foldcolumn = "0",
      scrolloff = 999,
      list = false,
      -- cursorline = false,
      conceallevel = 3,
    },
  },
  plugins = {
    twilight = { enabled = true },
  },
}
