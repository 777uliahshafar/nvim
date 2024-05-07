require("chatgpt").setup {
  chat = {
    question_sign = "", -- 🙂
    answer_sign = "ﮧ", -- 🤖
    border_left_sign = "",
    border_right_sign = "",
    keymaps = {
      yank_last = "<C-y>",
      scroll_up = "<C-u>",
      scroll_down = "<C-d>",
      toggle_settings = "<C-o>",
      new_session = "<C-n>",
      cycle_windows = "<Tab>",
      select_session = "<cr>",
    },
    buf_options = {
      filetype = "tex",
    },
  },
  popup_input = {
    submit = "<C-s>",
  },
}
