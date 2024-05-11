require("pantran").setup {
  default_engine = "google",
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
}
