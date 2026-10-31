local opts = { noremap = true, silent = true }

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

local ls = require "luasnip"
local wk = require "which-key"
local harpoon = require "harpoon"
local pantran = require "pantran"
-- local utils = require "core.utils"

-- Tambahkan fungsi claude helper ini tepat SEBELUM wk.add
-- Uncomment kembali untuk menggunakan keymap CLAUDE
-- local function claude_prompt(prompt)
--   return function()
--     vim.cmd "'<,'>ClaudeCodeSend"
--     require("claudecode.terminal").send_to_terminal(prompt)
--   end
-- end

-- which-key
wk.add {
  -- { "<leader>a", group = "AlphaIndex" },
  -- { "<leader>ai", "<cmd>Alpha<cr>", desc = "Alphaindex" },
  { "<leader>c", group = "Editing" },
  { "<leader>ci", "<cmd>setlocal spell! spelllang=id<cr>", desc = "bahasa spell" },
  { "<leader>ce", "<cmd>setlocal spell! spelllang=en_us<cr>", desc = "english spell" },
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
  -- { "<leader>d", group = "ChatGPT" },
  { "<localleader>d", group = "Colorscheme" },
  -- { "<leader>ff", "<cmd>Telescope oldfiles<cr>", desc = "Old files" },
  { "<localleader>f", "<cmd>Telescope live_grep<cr>", desc = "Live_grep" },
  { "<leader>w", "<cmd>Telescope buffers<cr>", desc = "buffers" },
  { "<localleader>w", group = "Windows" },
  {
    "<localleader>wm",
    function()
      -- Menggunakan variabel global Neovim untuk melacak status zoom
      if vim.g.window_maximized then
        vim.cmd "wincmd ="
        vim.g.window_maximized = false
      else
        vim.cmd "wincmd _ | wincmd |"
        vim.g.window_maximized = true
      end
    end,
    desc = "Toggle Maximize Split",
  },
  { "<localleader>wt", "<cmd>TroubleToggle<cr>", desc = "Toggle Diagnostics" },
  { "<localleader>we", "<cmd>bd!<cr>", desc = "Quit unsaved buffer" },
  { "<localleader>wj", "<C-w>t<C-w>H", desc = "Splits Vertically" },
  { "<localleader>wk", "<C-w>t<C-w>K", desc = "Splits Horizontally" },
  { "<localleader>wv", "<cmd>vs<cr>", desc = "Vertical Split" },
  { "<localleader>wh", "<cmd>sp<cr>", desc = "Horizontal Split" },
  { "<localleader>wu", "<cmd>res +5<cr>", desc = "Increase Window H" },
  { "<localleader>wd", "<cmd>res -5<cr>", desc = "Decrease Window H" },
  { "<localleader>wr", "<cmd>vertical res +5<cr>", desc = "Increase Window W" },
  { "<localleader>wl", "<cmd>vertical res -5<cr>", desc = "Decrease Window W" },
  { "<localleader>wq", "<cmd>tabclose<cr>", desc = "Close Tab" },

  { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
  -- Git
  { "<leader>g", group = "Git" },

  { "<leader>gg", "<cmd>G<cr>", desc = "Status" },
  { "<leader>ga", "<cmd>Gwrite<cr>", desc = "Stage file" },
  { "<leader>gc", "<cmd>Git commit<cr>", desc = "Commit" },

  { "<leader>gp", "<cmd>Git push<cr>", desc = "Push" },
  { "<leader>gP", "<cmd>Git pull<cr>", desc = "Pull" },

  { "<leader>gD", "<cmd>Gdiffsplit<cr>", desc = "Diff index" },
  { "<leader>gd", "<cmd>Gvdiffsplit HEAD<cr>", desc = "Diff HEAD" },
  { "<leader>ge", "<cmd>Gvdiffsplit HEAD~1<cr>", desc = "Diff HEAD~1" },

  { "<leader>gl", "<cmd>Gclog<cr>", desc = "Log" },
  { "<leader>gb", "<cmd>Git branch<cr>", desc = "Branches" },
  -- { "<localleader>gg", "<cmd>G<cr>", desc = "Git" },
  { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
  { "<leader>k", group = "Latex" },
  { "<localleader>l", group = "Latex+" },
  { "<leader>m", group = "MarkdownObs" },
  { "<leader>o", "<cmd>e ~/obs/1714384690-MAIN.md<CR>", desc = "Obsidian Index" },
  { "<leader>s", group = "Harpoon" },
  {
    "<leader>1",
    function()
      harpoon:list():select(1)
    end,
    desc = "harpoon 1",
    hidden = true,
  },
  {
    "<leader>2",
    function()
      harpoon:list():select(2)
    end,
    desc = "harpoon 2",
    hidden = true,
  },
  {
    "<leader>3",
    function()
      harpoon:list():select(3)
    end,
    desc = "harpoon 3",
    hidden = true,
  },
  {
    "<leader>4",
    function()
      harpoon:list():select(4)
    end,
    desc = "harpoon 4",
    hidden = true,
  },
  {
    "<leader>5",
    function()
      harpoon:list():select(5)
    end,
    desc = "harpoon 5",
    hidden = true,
  },
  {
    "<leader>6",
    function()
      harpoon:list():select(6)
    end,
    desc = "harpoon 6",
    hidden = true,
  },
  {
    "<leader>7",
    function()
      harpoon:list():select(7)
    end,
    desc = "harpoon 7",
    hidden = true,
  },
  {
    "<leader>8",
    function()
      harpoon:list():select(8)
    end,
    desc = "harpoon 8",
    hidden = true,
  },
  {
    "<leader>9",
    function()
      harpoon:list():select(9)
    end,
    desc = "harpoon 9",
    hidden = true,
  },
  {
    mode = { "n", "v" },
    { "<leader>c", group = "bahasa" },
    { "<leader>d", group = "english" },
    { "<leader>cp", "y<cmd>Pantran mode=interactive<cr>p", desc = "translate int" },
    { "<leader>cs", "<cmd>ThesaurusQueryReplaceCurrentWord<cr>", desc = "Thesaurus Query" },
    -- ==========================================
    -- CLAUDE: ENGLISH PROMPTS (<leader>d*)
    -- ==========================================
    -- {
    --   "<leader>db",
    --   claude_prompt "I am stuck in this following text, I need your help to describe this thing:",
    --   desc = "Stuck",
    -- },
    -- { "<leader>dc", claude_prompt "Parafrase dan perbaiki kode ini:", desc = "Claude: Code Fix" }, -- Menggantikan grammar_correction
    -- {
    --   "<leader>dd",
    --   claude_prompt "Develop the following ideas according to the spelling and grammar rules. Also, providing clear transitions between ideas:",
    --   desc = "Develop",
    -- },
    -- { "<leader>df", claude_prompt "Connect these two sentences for a cohesive paragraph:", desc = " Connect" },
    -- {
    --   "<leader>dg",
    --   claude_prompt "Please correct the spelling and grammar of the following text. Show the corrections in bold so I can see what has been corrected.",
    --   desc = " Grammar",
    -- },
    -- { "<leader>dm", claude_prompt "Summarize the following text:", desc = "Summarize" },
    -- {
    --   "<leader>dl",
    --   claude_prompt "Paraphrase the following sentence for use in an academic paper:",
    --   desc = "Paraphrase",
    -- },
    -- {
    --   "<leader>do",
    --   claude_prompt "Develop an outline for an academic article with the following research question:",
    --   desc = "Outline",
    -- },
    -- {
    --   "<leader>dr",
    --   claude_prompt "Refine the writing of the given text style to convey ideas with precision and impact. Focus on clarity by organizing thoughts logically, avoiding ambiguity, and providing clear transitions between ideas. Strive for conciseness by eliminating unnecessary wordiness.",
    --   desc = "Refine",
    -- },
    -- { "<leader>dt", claude_prompt "Translate this into English:", desc = "Claude: Translate (EN)" },
    -- {
    --   "<leader>dq",
    --   claude_prompt "Generate three possible research questions for an academic article on the following topic:",
    --   desc = "Quest",
    -- },

    -- ==========================================
    -- CLAUDE: BAHASA PROMPTS (<leader>c*)
    -- ==========================================
    -- {
    --   "<leader>cb",
    --   claude_prompt "Saya buntu pada teks berikut ini, bantu saya untuk menjelaskannya:",
    --   desc = "Buntu",
    -- },
    -- {
    --   "<leader>cd",
    --   claude_prompt "Susun ide-ide berikut sesuai dengan pedoman bahasa indonesia yang baik dan benar, serta gunakan transisi yang jelas antar ide:",
    --   desc = "Susun Ide",
    -- },
    -- { "<leader>cf", claude_prompt "Hubungkan dua kalimat ini untuk paragraf yang kohesif:", desc = "Hubung" },
    -- {
    --   "<leader>cg",
    --   claude_prompt "Perbaiki ejaan dan tata bahasa pada teks berikut sesuai EYD. Tunjukkan perbaikannya secara jelas:",
    --   desc = "EYD",
    -- },
    -- { "<leader>cm", claude_prompt "Rangkum tulisan berikut:", desc = "Claude: Rangkum" },
    -- {
    --   "<leader>cl",
    --   claude_prompt "Bertindaklah sebagai akademisi. Parafrasekan kalimat di bawah ini menggunakan bahasa Indonesia baku, formal, dan objektif yang cocok untuk publikasi jurnal ilmiah. Cukup berikan satu versi hasil parafrase terbaik tanpa penjelasan tambahan:",
    --   desc = "Parafrase",
    -- },
    -- {
    --   "<leader>co",
    --   claude_prompt "Kembangkan kerangka (outline) untuk artikel akademik dengan pertanyaan penelitian berikut:",
    --   desc = "Kerangka",
    -- },
    -- {
    --   "<leader>cr",
    --   claude_prompt "Perbaiki penulisan gaya teks berikut untuk menghasilkan ide yang presisi dan berdampak. Fokus pada kejelasan dengan penyusunan ide yang logis, hindari ambiguitas, serta gunakan transisi yang jelas antar ide. Pastikan teks ringkas dan gunakan tata bahasa Indonesia yang baik dan benar:",
    --   desc = "Perbaiki Teks",
    -- },
    -- {
    --   "<leader>ct",
    --   claude_prompt "Terjemahkan teks berikut ke dalam Bahasa Indonesia:",
    --   desc = "Translate (ID)",
    -- },
    -- {
    --   "<leader>cq",
    --   claude_prompt "Buat tiga pertanyaan penelitian potensial untuk artikel akademik tentang topik berikut:",
    --   desc = "Tanya",
    -- },

    -- ==========================================
    -- ChatGPT:  PROMPTS
    -- ==========================================
    -- { "<leader>db", "<cmd>ChatGPTRun stuck<cr>", desc = "Chat Stuck" },
    -- { "<leader>dc", "<cmd>ChatGPTRun grammar_correction<cr>", desc = "Chat Coherence" },
    -- { "<leader>dd", "<cmd>ChatGPTRun develop<cr>", desc = "Chat Develop 2 ideas" },
    -- { "<leader>df", "<cmd>ChatGPTRun connect<cr>", desc = "Chat connect" },
    -- { "<leader>dg", "<cmd>ChatGPTRun grammaronly<cr>", desc = "Chat grammar" },
    -- { "<leader>dm", "<cmd>ChatGPTRun summarize<cr>", desc = "Chat summarize" },
    -- { "<leader>dl", "<cmd>ChatGPTRun paraphrase<cr>", desc = "Chat paraphrase" },
    -- { "<leader>do", "<cmd>ChatGPTRun outline<cr>", desc = "Chat outline" },
    -- { "<leader>dr", "<cmd>ChatGPTRun refine<cr>", desc = "Chat refine" },
    -- { "<leader>dt", "<cmd>ChatGPTRun inggris<cr>", desc = "Chat translate" },
    -- { "<leader>dq", "<cmd>ChatGPTRun quest<cr>", desc = "Chat quest" },
    -- { "<leader>cb", "<cmd>ChatGPTRun buntu<cr>", desc = "Chat Buntu" },
    -- { "<leader>cd", "<cmd>ChatGPTRun susun<cr>", desc = "Chat Develop 2 ideas" },
    -- { "<leader>cf", "<cmd>ChatGPTRun hubung<cr>", desc = "Chat hubung" },
    -- { "<leader>cg", "<cmd>ChatGPTRun eyd<cr>", desc = "Chat eyd" },
    -- { "<leader>cm", "<cmd>ChatGPTRun rangkum<cr>", desc = "Chat rangkum" },
    -- { "<leader>cl", "<cmd>ChatGPTRun parafrase<cr>", desc = "Chat parafrase" },
    -- { "<leader>co", "<cmd>ChatGPTRun kerangka<cr>", desc = "Chat outline" },
    -- { "<leader>cr", "<cmd>ChatGPTRun perbaiki<cr>", desc = "Chat perbaiki" },
    -- { "<leader>ct", "<cmd>ChatGPTRun bahasa<cr>", desc = "Chat terjemahkan" },
    -- { "<leader>cq", "<cmd>ChatGPTRun tanya<cr>", desc = "Chat tanya" },
    -- { "<leader>", "<cmd>ChatGPT<cr>", desc = "ChatGPT Prompt" },
  }, -- end mode nv
  {
    mode = { "n" },
    -- ==========================================
    -- Gemini:  PROMPTS
    -- ==========================================

    { "<leader>cf", "<cmd>GemsConnectSentences<cr>", desc = "AI Connect Sentences" },

    { "<leader>cl", "<cmd>GemsParaphrase<cr>", desc = "AI Paraphrase Sentence" },

    { "<leader>cR", "<cmd>GemsRefineSentence<cr>", desc = "AI Refine Sentence" },

    { "<leader>ct", "<cmd>GemsTranslateEnglish<cr>", desc = "AI Translate to English" },

    { "<leader>dt", "<cmd>GemsTranslateBahasa<cr>", desc = "AI Translate to Bahasa" },
  }, --end mode n
  {
    mode = { "x" },

    { "<leader>cL", ":<C-u>GemvParaphrase<CR>", desc = "AI Paraphrase Selection" },

    { "<leader>cm", ":<C-u>GemvSummarize<CR>", desc = "AI Summarize Selection" },

    { "<leader>cg", ":<C-u>GemvGrammar<CR>", desc = "AI Grammar Correction" },

    { "<leader>cr", ":<C-u>GemvRefine<CR>", desc = "AI Refine Writing" },

    { "<leader>co", ":<C-u>GemvOutline<CR>", desc = "AI Academic Outline" },

    { "<leader>ca", ":<C-u>GemvMainidea<CR>", desc = "AI Main Idea" },
  }, -- end mode x
  {
    mode = { "i" },
    { "<F2>", "<c-r>=strftime('%b%d')<cr>", desc = "Timestamp" },
    { "<F3>", "<C-r>*", desc = "Paste Clipboard" },
  }, -- end mode i
} -- end wk add

-- ==========================================
-- General
-- ==========================================

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
map("n", "<localleader>wu", "<cmd>res +5<CR>", opts)
map("n", "<localleader>wd", "<cmd>res -5<CR>", opts)
map("n", "<localleader>wu", "<cmd>vertical res +5<CR>", opts)
map("n", "<localleader>wd", "<cmd>vertical res -5<CR>", opts)

-- working dir
map("n", "<localleader>rd", "<CMD>lcd %:h<CR>")
map("n", "<localleader>rc", "<CMD>cd %:h<CR>")

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
map("n", "<localleader>dg", "<CMD>colorscheme gruvbox<CR>", { desc = "co gruvbox" })
-- map("n", "<localleader>cp", "<CMD>colorscheme PaperColor<CR>", { desc = "co papercolor" })
map("n", "<localleader>dk", "<CMD>colorscheme kanagawa<CR>", { desc = "co kanagawa-kanagawa" })
map("n", "<localleader>dr", "<CMD>colorscheme kanagawa-dragon<CR>", { desc = "co kanagawa-dragon" })
-- map("n", "<localleader>cw", "<CMD>colorscheme kanagawa-wave<CR>", { desc = "co kanagawa-wave" })
map("n", "<localleader>dn", "<CMD>colorscheme carbonfox<CR>", { desc = "co carbonfox" })
map("n", "<localleader>dd", "<CMD>colorscheme catppuccin-latte<CR>", { desc = "co catppuccin" })
map("n", "<localleader>dz", "<CMD>colorscheme zenbones<CR>", { desc = "co zenbones" })
map("n", "<localleader>dw", "<CMD>colorscheme zenwritten<CR>", { desc = "co zenwritten" })
map("n", "<localleader>dp", "<CMD>colorscheme onedark<CR>", { desc = "co onedark" })
map("n", "<localleader>ds", "<CMD>colorscheme dawnfox<CR>", { desc = "co dawnfox" })

---------------------------------------------
-- PLUGIN KEYBINDING
---------------------------------------------
-- nvim-tree
map("n", "<localleader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- zen mode
map("n", "zz", require("zen-mode").toggle)
map("n", "<leader>z", "<CMD>Limelight!!<CR>", opts)
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

local map = vim.keymap.set

map("n", "gz", "<CMD>ZoomToggle<cr>")

-- vim-bufsurf
map("n", "<bs>", "<Plug>(buf-surf-back)")

-- claude terminal
map("t", "<S-CR>", "<CR>", opts)

-- vim.api.nvim_buf_set_keymap(0, "", "<localleader>d", "<cmd>BookmarksQFListAll<cr>", { noremap = false })

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
