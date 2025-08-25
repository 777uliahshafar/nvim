require("chatgpt").setup {
  actions_paths = { "~/AppData/Local/nvim/actions.json" },
  openai_params = {
    -- NOTE: model can be a function returning the model name
    -- this is useful if you want to change the model on the fly
    -- using commands
    -- Example:
    -- model = function()
    --     if some_condition() then
    --         return "gpt-4-1106-preview"
    --     else
    --         return "gpt-3.5-turbo"
    --     end
    -- end,
    model = "gpt-4",
    frequency_penalty = 0,
    presence_penalty = 0,
    max_tokens = 4095,
    temperature = 0.2,
    top_p = 0.1,
    n = 1,
  },
  popup_window = {
    border = {
      highlight = "FloatBorder",
      style = "rounded",
      text = {
        top = " ChatGPT ",
      },
    },
    win_options = {
      wrap = true,
      linebreak = true,
      foldcolumn = "1",
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
    buf_options = {
      filetype = "markdown",
    },
  },
  chat = {
    question_sign = "", -- 🙂
    answer_sign = "ﮧ", -- 🤖
    -- border_left_sign = "",
    -- border_right_sign = "",
    welcome_message = "<c-n> new session, <c-p> sessions, r rename session, <space> select <c-o> settings <c-h> help. ~ Robert Half",
    loading_text = "Loading, please wait ...",
    default_system_message = "",
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
  popup_input = {
    wrap = true,
    prompt = "  ",
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
    submit = "<c-s>",
    submit_n = "<Enter>",
    max_visible_lines = 20,
  },
  highlights = {
    active_session = "@symbol",
  },
}
