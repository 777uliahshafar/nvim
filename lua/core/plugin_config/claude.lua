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
        winbar = "",
        -- Option 2: Use a custom local statusline string if desired
        statusline = "%{b:snacks_terminal.id}: %{b:term_title}",
      },
      keys = {
        term_normal = { "<esc>", "<C-\\><C-n>", mode = "t", desc = "Ke Normal Mode" },
      }, -- tekan sekali untuk pindah mode, rentan masalah dengan cli lain pada terminal
    },
  },
  keys = {
    --
  },
}
