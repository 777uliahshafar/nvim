local opts = { noremap = true, silent = true }

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

local ls = require "luasnip"
local wk = require "which-key"
local utils = require "core.utils"

-- which-key
wk.add {
  { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "buffers| backlinks" },
  { "<leader>ck", "<cmd>lua vim.g.cmptoggle = not vim.g.cmptoggle<cr>", desc = "toggle nvim-cmp" },
  { "<leader>dd", "<cmd>TroubleToggle<cr>", desc = "Trouble diagnostic" },
  { "<leader>fa", "<cmd>Gwrite<cr>", desc = "Gwrite| from template" },
  { "<leader>fc", "<cmd>Git commit<cr>", desc = "Git commit m" },
  { "<leader>fd", "<cmd>Gvdiffsplit head<cr>", desc = "Git diff head" },
  { "<leader>fe", "<cmd>Gvdiffsplit head~1<cr>", desc = "Gvdiffsplit head~1|template" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
  { "<leader>fg", "<cmd>G<cr>", desc = "Git" },
  { "<leader>fh", "<cmd>Telescope oldfiles<cr>", desc = "Old files" },
  { "<leader>fp", "<cmd>Git push<cr>", desc = "Git push" },
  { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Live_grep" },
  { "<leader>g", "<cmd>ChatGPT<cr>", desc = "ChatGPT Prompt" },
  { "<leader>o", group = "spell" },
  { "<leader>oo", "<cmd>setlocal spell! spelllang=en_us<cr>", desc = "english spell" },
  { "<leader>os", "<cmd>setlocal spell! spelllang=id<cr>", desc = "bahasa spell" },
  { "<leader>a", "<cmd>Alpha<cr>", desc = "Alphaindex" },
  { "<leader>wh", "<C-w>t<C-w>H", desc = "switch to vertical orientation" },
  { "<leader>wk", "<C-w>t<C-w>K", desc = "switch to horizontal orientation" },
  {
    mode = { "n", "v" },
    { "<leader>cp", "y<cmd>Pantran<cr>p", desc = "translate" },
    { "<leader>cs", "<cmd>ThesaurusQueryReplaceCurrentWord<cr>", desc = "Thesaurus Query" },
    { "<leader>cc", "<cmd>ChatGPTRun translate<cr>", desc = "Chat translate" },
  },

  {
    mode = { "i" },
    { "<F3>", "<c-r>=strftime('%b%d')<cr>", desc = "Timestamp" },
  },
}

-- Mimic shell movements
map("i", "<C-E>", "<ESC>A")
map("i", "<C-A>", "<ESC>I")

-- maps for go down and up
map("n", "j", "gj", { noremap = true })
map("n", "k", "gk", { noremap = true })

-- maps split navigation
map("n", "<c-h>", "<c-w>h") -- vim interpret <c-h> as <c-bs>
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>w")

-- split resize
map("n", "+", "<cmd>res +5<CR>", opts)
map("n", "_", "<cmd>res -5<CR>", opts)

-- working dir
map("n", "<localleader>lcd", "<CMD>lcd %:h<CR>")
map("n", "<localleader>cd", "<CMD>cd %:h<CR>")

-- map buffer
map("n", "<c-b>", "<CMD>ls<CR>:b<Space>", opts)
-- map("n", "<leader>h", "<CMD>bprevious<CR>", opts)
-- map("n", "<leader>l", "<CMD>bnext<CR>", opts)
map("n", "<leader><esc>", "<CMD>nohlsearch<CR>", opts)

--  navigate through popup pum menu
vim.api.nvim_set_keymap("i", "<CR>", 'pumvisible() ? "\\<C-y>" : "\\<c-g>u<CR>"', { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', { expr = true, noremap = true })
--vim.api.nvim_set_keymap('i', '<Esc>', 'pumvisible() ? "\\<C-e>" : "\\<Esc>"', {expr = true, noremap = true})

-- Change/swap split orientation
-- map("n", "<leader>tk", "<C-w>t<C-w>K") -- change vertical to horizontal
-- map("n", "<leader>th", "<C-w>t<C-w>H") -- change horizontal to vertical
-- maps for  spellcheck
-- map("n", "<leader>o", "<CMD>setlocal spell! spelllang=id<CR>")

-- map("n", "<leader>us", "<CMD>setlocal spell! spelllang=en_us<CR>")
-- Load recent sessions
-- map("n", "<leader>sl", "<CMD>SessionLoad<CR>")

map("n", "<f2>", "<CMD>h mycheat<CR>")
map("n", "<f5>", "<CMD>ToggleBackground<CR>")
map("n", "<f8>", "<CMD>colorscheme melange<CR>")
map("n", "<f7>", "<CMD>colorscheme kanagawa<CR>")
map("n", "<f6>", "<CMD>colorscheme gruvbox<CR>")

---------------------------------------------
-- PLUGIN KEYBINDING
---------------------------------------------
-- nvim-tree
map("n", "<leader>e", require("nvim-tree.api").tree.toggle)

-- zen mode
map("n", "<leader>z", require("zen-mode").toggle)
map("n", "zz", require("twilight").toggle, opts)

-- luasnip
-- <c-j> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
map({ "i", "s" }, "<c-l>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end)

-- <c-k> is my jump backwards key.
-- this always moves to the previous item within the snippet
map({ "i", "s" }, "<c-h>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end)

map("i", "<c-j>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

map("i", "<c-k>", function()
  if ls.choice_active() then
    ls.change_choice(-1)
  end
end)

-- harpoon
map("n", "<leader>hn", require("harpoon.ui").nav_next)
map("n", "<leader>hp", require("harpoon.ui").nav_prev)
utils.map("n", [[<leader>hm]], ":Telescope harpoon marks<CR>")

map("n", "<leader>hx", require("harpoon.mark").add_file)

-- quickfix built-in
vim.cmd [[
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
]]

map("n", "gz", "<CMD>ZoomToggle<cr>")

-- vim-bufsurf
map("n", "<bs>", "<Plug>(buf-surf-back)")

-- map("v", "<leader>tr", "y<cmd>Pantran<cr>p")

-- obsidian
-- map("n", "<leader>lw", "<CMD>ObsidianSearch<CR>")

-- nvim-cmp
-- map("n", "<leader>ua", "<cmd>lua vim.g.cmptoggle = not vim.g.cmptoggle<CR>", { desc = "toggle nvim-cmp" })

-- trouble
-- map("n", "<leader>tt", "<cmd>TroubleToggle<cr>")

-- vim fugitive
-- map("n", "<leader>g", "<CMD>G<CR>", opts)
-- map("n", "<leader>fa", "<CMD>Gwrite<CR>", opts)
-- map("n", "<leader>fd", "<CMD>Gvdiffsplit head<CR>", opts)
-- map("n", "<localleader>fd", "<CMD>Gvdiffsplit head~1<CR>", opts)
-- map("n", "<leader>fp", "<CMD>Git push<CR>", opts)
-- map("n", "<leader>fc", "<CMD>Git commit<CR>", opts)

-- thesaurus_query
-- map("n", "<leader>cs", "<cmd>ThesaurusQueryReplaceCurrentWord<cr>", opts)
-- vim.cmd [[vnoremap <Leader>cs y:ThesaurusQueryReplace <C-r>"<CR>]]

-- chatGPT
-- map("n", "<leader>cc", "<CMD>ChatGPT<CR>", opts)
-- map({ "n", "v" }, "<leader>ct", "<cmd>ChatGPTRun translate<CR>", opts)
