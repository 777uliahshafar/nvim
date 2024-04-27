local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local startify = require "alpha.themes.startify"

startify.section.header.val = {
  [[          ▀████▀▄▄              ▄█ ]],
  [[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
  [[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
  [[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
  [[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
  [[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
  [[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
  [[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
  [[   █   █  █      ▄▄           ▄▀   ]],
}
startify.section.top_buttons.val = {
  startify.button("e", " > New File", "<cmd>ene<CR>"),
  startify.button("a", "AAS essay", "<cmd>e D:/essay/subfiles/aasessay.tex<CR>"),
  startify.button("b", "Karakter", "<cmd>e D:/karakter/karakter.tex<CR>"),
  startify.button("c", "BPI-en", "<cmd>e D:/proposal/subfiles/prop-en.tex<CR>"),
  startify.button("d", "essay", "<cmd>e D:/essay/subfiles/esai-en.tex<CR>"),
  startify.button("o", "Obsidian", "<cmd>ObsidianSearch<CR>"),
}

startify.section.bottom_buttons.val = {
  startify.button("SPC ff", " > Find File", "<cmd>Telescope find_files<CR>"),
  startify.button("SPC fw", " > Find Word", "<cmd>Telescope live_grep<CR>"),
  startify.button("z", " > Find Config", "<cmd>e C:/Users/uliah/AppData/Local/nvim/init.lua<CR>"),
}

alpha.setup(startify.opts)
