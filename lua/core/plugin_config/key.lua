require("which-key").setup {
  marks = false,
  suggestions = 15,
  triggers = {
    { "<leader>", mode = { "n", "v" } },
    { "<localleader>", mode = { "n" } },
  },
}
