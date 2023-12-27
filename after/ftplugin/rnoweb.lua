local o = vim.o

local opts = { noremap = true, silent = true }

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

o.expandtab = false
o.shiftwidth = 4
o.softtabstop = 4

map({ "n", "v" }, "<leader><space>", ':call SendLineToR("stay")<CR>')
map("n", "<localleader>rf", ':call StartR("R")<CR>', opts)
map("n", "<localleader>ro", ":call RObjBrowser()<CR>", opts)
map("n", "<localleader>rh", ':call RAction("help")<CR>', opts)
map("n", "<localleader>rv", ':call RAction("viewobj")<CR>', opts)

map("n", "<localleader>lp", "<Plug>RSyncFor")

map("t", "jk", [[<C-\><C-n>]], opts) --Use jk for enter normal mode from terminal mode

map("n", "<localleader>ln", "<Plug>RNextRChunk")
map("n", "<localleader>lN", "<Plug>RPreviousRChunk")
