require("pantran").setup {
  default_engine = "google",
  engines = {
    google = {
      -- Default languages can be defined on a per engine basis. In this case
      -- `:lua require("pantran.async").run(function()
      -- vim.pretty_print(require("pantran.engines").yandex:languages()) end)`
      -- can be used to list available language identifiers.
      default_source = "id",
      default_target = "en",
    },
  },
  default_source = {},
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
