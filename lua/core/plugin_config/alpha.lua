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
  startify.button("c", "BPI-en", "<cmd>e D:/essay/subfiles/esai-en.tex<CR>"),
}

startify.section.bottom_buttons.val = {
  startify.button("SPC pff", " > Find File", "<cmd>Telescope find_files<CR>"),
  startify.button("SPC pfw", " > Find Word", "<cmd>Telescope live_grep<CR>"),
  startify.button("z", " > Find Word", "<cmd>e C:/Users/uliah/AppData/Local/nvim/lua/core/plugin_config/alpha.lua<CR>"),
}

alpha.setup(startify.opts)
