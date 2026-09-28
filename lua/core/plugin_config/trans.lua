require("pantran").setup {
  default_engine = "deepl",
  command = { default_mode = "yank" },
  engines = {
    deepl = {
      fallback = {
        default_source = "id",
        default_target = "en",
        free_api = false,
      },
    },
    google = {
      fallback = {
        default_source = "id",
        default_target = "en",
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
