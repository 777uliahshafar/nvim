local opts = { noremap = true, silent = true }

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

local ls = require "luasnip"
local wk = require "which-key"
local harpoon = require "harpoon"
local pantran = require "pantran"
-- local utils = require "core.utils"

-- which-key
wk.add {
  -- { "<leader>a", group = "AlphaIndex" },
  -- { "<leader>ai", "<cmd>Alpha<cr>", desc = "Alphaindex" },
  { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "buffers| backlinks" },
  { "<leader>c", group = "Editing" },
  { "<leader>cb", "<cmd>setlocal spell! spelllang=id<cr>", desc = "bahasa spell" },
  { "<leader>ci", "<cmd>setlocal spell! spelllang=en_us<cr>", desc = "english spell" },
  {
    "<leader>cpp",
    function()
      return pantran.motion_translate() .. "_"
    end,
    opts,
    expr = true,
    desc = "translate para",
  },
  {
    "<leader>cps",
    function()
      return pantran.motion_translate() .. "is"
    end,
    noremap = true,
    silent = true,
    expr = true,
    desc = "translate sente",
  },
  {
    "<leader>cpw",
    function()
      return pantran.motion_translate() .. "iw"
    end,
    noremap = true,
    silent = true,
    expr = true,
    desc = "translate word",
  },
  { "<leader>ck", "<cmd>lua vim.g.cmptoggle = not vim.g.cmptoggle<cr>", desc = "toggle nvim-cmp" },
  { "<leader>d", group = "ChatGPT" },
  { "<localleader>d", group = "PWD" },
  -- { "<leader>ff", "<cmd>Telescope oldfiles<cr>", desc = "Old files" },
  { "<localleader>f", "<cmd>Telescope live_grep<cr>", desc = "Live_grep" },
  { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
  { "<leader>g", group = "Git" },
  { "<leader>ga", "<cmd>Gwrite<cr>", desc = "Gwrite| from template" },
  { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit m" },
  { "<leader>gd", "<cmd>Gvdiffsplit head<cr>", desc = "Git diff head" },
  { "<leader>ge", "<cmd>Gvdiffsplit head~1<cr>", desc = "Gvdiffsplit head~1|template" },
  { "<leader>gg", "<cmd>G<cr>", desc = "Git" },
  { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
  { "<leader>k", group = "Latex" },
  { "<localleader>l", group = "Latex+" },
  { "<leader>m", group = "MarkdownObs" },
  { "<leader>o", "<cmd>e ~/obs/1714384690-MAIN.md<CR>", desc = "Obsidian Index" },
  { "<leader>s", group = "Harpoon" },
  { "<leader>w", group = "Windows" },
  { "<leader>wt", "<cmd>TroubleToggle<cr>", desc = "Trouble diagnostic" },
  { "<leader>wh", "<C-w>t<C-w>H", desc = "switch to vertical orientation" },
  { "<leader>wk", "<C-w>t<C-w>K", desc = "switch to horizontal orientation" },
  {
    mode = { "n", "v" },
    { "<leader>c", group = "bahasa" },
    { "<leader>d", group = "english" },
    { "<leader>cp", "y<cmd>Pantran mode=interactive<cr>p", desc = "translate int" },
    { "<leader>cs", "<cmd>ThesaurusQueryReplaceCurrentWord<cr>", desc = "Thesaurus Query" },
    { "<leader>dt", "<cmd>ChatGPTRun inggris<cr>", desc = "Chat translate" },
    { "<leader>df", "<cmd>ChatGPTRun connect<cr>", desc = "Chat connect" },
    { "<leader>dg", "<cmd>ChatGPTRun grammaronly<cr>", desc = "Chat grammar" },
    { "<leader>dp", "<cmd>ChatGPTRun stuck<cr>", desc = "Chat Stuck" },
    { "<leader>dc", "<cmd>ChatGPTRun grammar_correction<cr>", desc = "Chat Coherence" },
    { "<leader>dm", "<cmd>ChatGPTRun summarize<cr>", desc = "Chat summarize" },
    { "<leader>dl", "<cmd>ChatGPTRun paraphrase<cr>", desc = "Chat paraphrase" },
    { "<leader>cc", "<cmd>ChatGPT<cr>", desc = "ChatGPT Prompt" },
    { "<leader>ct", "<cmd>ChatGPTRun bahasa<cr>", desc = "Chat terjemahkan" },
    { "<leader>cg", "<cmd>ChatGPTRun tata_bahasa<cr>", desc = "Chat tata bahasa" },
    { "<leader>cm", "<cmd>ChatGPTRun rangkum<cr>", desc = "Chat rangkum" },
    { "<leader>cl", "<cmd>ChatGPTRun parafrase<cr>", desc = "Chat parafrase" },
  },
  {
    mode = { "i" },
    { "<F2>", "<c-r>=strftime('%b%d')<cr>", desc = "Timestamp" },
    { "<F3>", "<C-r>*", desc = "Paste Clipboard" },
  },
  -- {
  --   mode = { "x" },
  --   { "<leader>cp", pantran.motion_translate, noremap = true, silent = true, expr = true, desc = "translate" },
  -- },
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
map("n", "<c-l>", "<c-w>l") -- "<c-w>w" cycle nav

-- split resize
map("n", "+", "<cmd>res +5<CR>", opts)
map("n", "_", "<cmd>res -5<CR>", opts)

-- working dir
map("n", "<localleader>dd", "<CMD>lcd %:h<CR>")
map("n", "<localleader>dc", "<CMD>cd %:h<CR>")

-- map buffer
map("n", "<c-b>", "<CMD>ls<CR>:b<Space>", opts)
map("n", "<c-p>", "<CMD>bprevious<CR>", opts)
map("n", "<c-n>", "<CMD>bnext<CR>", opts)
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
map("n", "<f9>", "<CMD>colorscheme gruvbox<CR>")
map("n", "<f8>", "<CMD>colorscheme PaperColor<CR>")
map("n", "<f7>", "<CMD>colorscheme kanagawa<CR>")
map("n", "<localleader>w", "<CMD>colorscheme kanagawa-wave<CR>", opts, { desc = "co kanagawa-wave" })

---------------------------------------------
-- PLUGIN KEYBINDING
---------------------------------------------
-- nvim-tree
map("n", "<leader>e", require("nvim-tree.api").tree.toggle)

-- zen mode
map("n", "<leader>z", require("zen-mode").toggle)
map("n", "<localleader>z", "<CMD>Limelight!!<CR>", opts)
-- map("n", "<localleader>z", require("twilight").toggle, opts)

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
vim.keymap.set("n", "<leader>h", function()
  harpoon:list():prev { ui_nav_wrap = true }
end, { desc = "jump prev" })
vim.keymap.set("n", "<leader>l", function()
  harpoon:list():next { ui_nav_wrap = true }
end, { desc = "jump next" })
vim.keymap.set("n", "<leader>sa", function()
  harpoon:list():add()
end, { desc = "add file" })
map("n", "<leader>sm", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", "<leader>sd", function()
  harpoon:list():remove()
end, { desc = "delete mark" })

-- map("n", "<leader>hn", require("harpoon.ui").nav_next)
-- map("n", "<leader>hp", require("harpoon.ui").nav_prev)
-- utils.map("n", [[<leader>hm]], ":Telescope harpoon marks<CR>")

-- map("n", "<leader>hx", require("harpoon.mark").add_file)

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
