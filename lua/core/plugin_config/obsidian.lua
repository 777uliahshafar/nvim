require("obsidian").setup {
  dir = "note",
  version = "*",
  lazy = true,
  ft = "markdown",
  -- dir = "jot", -- auto put folders in nvim config
  daily_notes = {
    folder = "journal",
  },
  notes_subdir = "doc",

  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },
  -- templates = {
  --   subdir = "my-templates-folder",
  --   date_format = "%Y-%m-%d",
  --   time_format = "%H:%M",
  -- },
}
