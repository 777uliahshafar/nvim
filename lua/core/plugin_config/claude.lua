require("claudecode").setup {
  terminal = {
    split_side = "right",
    terminal_cmd = "claude --theme dark",
    snacks_win_opts = {
      position = "bottom",
      height = 0.4,
      width = 1.0,
      border = "rounded",
      signcolumn = "yes",
      wo = {
        -- Option 1: Disable the statusline completely for the terminal window
        -- statusline = "",

        -- Option 2: Use a custom local statusline string if desired
        statusline = "%{b:snacks_terminal.id}: %{b:term_title}",
      },
    },
  },
}

-- require("claudecode").setup {
--   terminal = {
--     snacks_win_opts = {
--       position = "float",
--       width = 0.6,
--       height = 0.6,
--       border = "double",
--       backdrop = 80,
--       keys = {
--         claude_hide = {
--           "<Esc>",
--           function(self)
--             self:hide()
--           end,
--           mode = "t",
--           desc = "Hide",
--         },
--         claude_close = { "q", "close", mode = "n", desc = "Close" },
--       },
--     },
--   },
-- }
