require("chatgpt").setup {
  chat = {
    keymaps = {
      yank_last = "<C-y>",
      scroll_up = "<C-u>",
      scroll_down = "<C-d>",
      toggle_settings = "<C-o>",
      new_session = "<C-n>",
      cycle_windows = "<Tab>",
    },
  },
  popup_input = {
    submit = "<C-s>",
  },
}
