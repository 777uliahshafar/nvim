require("pantran").setup {
  default_engine = "google",
  engines = {
    google = {
      fallback = {
        default_source = "en",
        default_target = "id",
      },
    },
    yandex = {
      fallback = {
        default_source = "id",
        default_target = "en",
      },
    },
  },
  controls = {
    mappings = {
      edit = {
        n = {
          -- Use this table to add additional mappings for the normal mode in
          -- the translation window. Either strings or function references are
          -- supported.
          ["<Esc>"] = false,
        },
      },
    },
  },
  window = {
    title_border = { " ", "" },
  },
}
