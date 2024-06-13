local opts = { noremap = true, silent = true }

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

local ls = require "luasnip"
local wk = require "which-key"
local builtin = require "telescope.builtin"

-- which-key
wk.register({
  o = {
    name = "spell", -- optional group name
    s = { "<cmd>setlocal spell! spelllang=id<cr>", "bahasa spell" },
    o = { "<cmd>setlocal spell! spelllang=en_us<cr>", "english spell" },
  }, -- end first key
  t = {
    k = { "<C-w>t<C-w>K", "switch to horizontal orientation" },
    h = { "<C-w>t<C-w>H", "switch to vertical orientation" },
  }, -- end first key
  c = {
    m = {
      "<cmd>lua vim.g.cmptoggle = not vim.g.cmptoggle<cr>",
      "toggle nvim-cmp",
    },
    s = {
      "<cmd>ThesaurusQueryReplaceCurrentWord<cr>",
      "Thesaurus Query",
      mode = { "v", "n" },
    },
    h = { "<cmd>ChatGPT<cr>", "ChatGPT Prompt" },
    t = { "<cmd>ChatGPTRun translate<cr>", "Chat translate", mode = { "v", "n" } },
    p = { "y<cmd>Pantran<cr>p", "translate", mode = { "v", "n" } },
    n = { "<cmd>colorscheme melange<cr>", "melange" },
    g = { "<cmd>colorscheme gruvbox<cr>", "gruvbox" },
    k = { "<cmd>colorscheme kanagawa<cr>", "kanagawa" },
  }, -- end first key
  f = {
    f = {
      function()
        builtin.find_files()
      end,
      "Find files",
    },
    w = {
      function()
        builtin.live_grep()
      end,
      "Live_grep",
    },
    b = {
      function()
        builtin.buffers()
      end,
      "Find buffers",
    },
    h = {
      function()
        builtin.oldfiles()
      end,
      "Old files",
    },

    g = { "<cmd>G<cr>", "Git" },
    a = {
      "<cmd>Gwrite<cr>",
      "Git write",
    },
    d = {
      "<cmd>Gvdiffsplit head<cr>",
      "Git diff head",
    },
    e = {
      "<cmd>Gvdiffsplit head~1<cr>",
      "Gvdiffsplit head~1",
    },
    c = {
      "<cmd>Git commit<cr>",
      "Git commit m",
    },
    p = {
      "<cmd>Git push<cr>",
      "Git push",
    },
    o = {
      "<cmd>ObsidianSearch<cr>",
      "Obsidian search",
    },
  }, -- end first key
  d = {
    d = { "<cmd>TroubleToggle<cr>", "Trouble diagnostic" },
  }, -- end first key
}, { prefix = "<leader>" })

-- Mimic shell movements
map("i", "<C-E>", "<ESC>A")
map("i", "<C-A>", "<ESC>I")

-- maps for go down and up
map("n", "j", "gj", { noremap = true })
map("n", "k", "gk", { noremap = true })

-- maps split navigation
map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")

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

map("n", "<f5>", "<CMD>ToggleBackground<CR>")
map("n", "<f4>", "<CMD>Alpha<CR>")

---------------------------------------------
-- PLUGIN KEYBINDING
---------------------------------------------
-- nvim-tree
map("n", "<leader>e", require("nvim-tree.api").tree.toggle)

-- zen mode
map("n", "<leader>z", require("zen-mode").toggle)

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

--nvim surround
map("i", "<c-s>s", "<Plug>(nvim-surround-insert)")

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
