local opts = { noremap = true, silent = true }

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

local ls = require "luasnip"

-- Mimic shell movements
map("i", "<C-E>", "<ESC>A")
map("i", "<C-A>", "<ESC>I")

-- Load recent sessions
map("n", "<leader>sl", "<CMD>SessionLoad<CR>")

map("n", "<f5>", "<CMD>ToggleBackground<CR>")

-- maps for go down and up
map("n", "j", "gj", { noremap = true })
map("n", "k", "gk", { noremap = true })

-- maps for  spellcheck
map("n", "<leader>o", "<CMD>setlocal spell! spelllang=id<CR>")

map("n", "<F7>", "<CMD>setlocal spell! spelllang=en_us<CR>")

-- maps split navigation
map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")

-- Change split orientation
map("n", "<leader>tk", "<C-w>t<C-w>K") -- change vertical to horizontal
map("n", "<leader>th", "<C-w>t<C-w>H") -- change horizontal to vertical

-- split resize
map("n", "+", "<cmd>res +5<CR>", opts)
map("n", "_", "<cmd>res -5<CR>", opts)

-- working dir
map("n", "<localleader>lcd", "<CMD>lcd %:h<CR>")
map("n", "<localleader>cd", "<CMD>cd %:h<CR>")

-- map buffer
map("n", "<c-b>", "<CMD>ls<CR>:b<Space>", opts)
map("n", "<leader>h", "<CMD>bprevious<CR>", opts)
map("n", "<leader>l", "<CMD>bnext<CR>", opts)

map("n", "<leader><esc>", "<CMD>nohlsearch<CR>", opts)

--  navigate through popup pum menu
--vim.api.nvim_set_keymap('i', '<Esc>', 'pumvisible() ? "\\<C-e>" : "\\<Esc>"', {expr = true, noremap = true})
vim.api.nvim_set_keymap("i", "<CR>", 'pumvisible() ? "\\<C-y>" : "\\<c-g>u<CR>"', { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', { expr = true, noremap = true })

---------------------------------------------
-- PLUGIN KEYBINDING
---------------------------------------------

-- nvim-tree
map("n", "<leader>e", require("nvim-tree.api").tree.toggle)

-- zen mode
map("n", "<leader>z", require("zen-mode").toggle)

-- nvim-cmp
map("n", "<leader>ua", "<cmd>lua vim.g.cmptoggle = not vim.g.cmptoggle<CR>", { desc = "toggle nvim-cmp" })

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

-- trouble
map("n", "<leader>tt", "<CMD>TroubleToggle<cr>")

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

-- Neorg
map("n", "<leader>nn", "<CMD>Neorg workspace main<CR>")

-- vim fugitive
map("n", "<leader>gf", "<CMD>G<CR>", opts)
map("n", "<leader>gw", "<CMD>Gwrite<CR>", opts)

-- thesaurus_query
map("n", "<leader>cs", "<CMD>ThesaurusQueryReplaceCurrentWord<CR>", opts)
