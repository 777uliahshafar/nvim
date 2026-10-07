require("claudecode").setup {
  focus_after_send = true,
  terminal = {
    split_side = "right",
    split_width_percentage = 0.35,
    snacks_win_opts = {
      border = "rounded",
      signcolumn = "yes",
      wo = {
        winbar = "",
        -- Option 2: Use a custom local statusline string if desired
        statusline = "%{b:snacks_terminal.id}: %{b:term_title}",
      },
      keys = {
        term_normal = { "<esc>", "<C-\\><C-n>", mode = "t", desc = "Ke Normal Mode" }, -- tekan sekali untuk pindah mode, rentan masalah dengan cli lain pada terminalA
      },
    },
  },
  keys = {
    --
  },
}
