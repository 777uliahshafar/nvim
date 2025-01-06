require("chatgpt").setup {
  chat = {
    question_sign = "", -- 🙂
    answer_sign = "ﮧ", -- 🤖
    border_left_sign = "",
    border_right_sign = "",
    keymaps = {
      close = "<C-c>",
      close_n = "q",
      yank_last = "<C-y>",
      scroll_up = "<C-u>",
      scroll_down = "<C-d>",
      toggle_settings = "<C-o>",
      new_session = "<C-n>",
      cycle_windows = "<Tab>",
      select_session = "<cr>",
      edit_message = "<C-e>",
    },
    buf_options = {
      filetype = "tex",
    },
  },
}
