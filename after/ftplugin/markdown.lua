local o = vim.opt

-- markdown ftplugin
vim.opt_local.colorcolumn = "101"
-- o.autoindent = true
o.linebreak = true
-- @TODOUA:
-- spell is not staying local for some reason
-- have to set nospell in other fts that are opened after a markdown
vim.opt_local.conceallevel = 2
vim.opt_local.shiftwidth = 0
vim.opt_local.spell = false
o.spelllang = { "en_us", "id" }
o.updatetime = 1000

-- *markdown surround maps - with nvim-surround and without*
-- wrap selection in markdown link
vim.api.nvim_buf_set_keymap(0, "v", "<leader>mf", [[c[<c-r>"]()<esc>]], { noremap = false })

-- italicize Word - in visual: S{arg}
-- vim.api.nvim_buf_set_keymap(0, "n", "<leader>_", "ysiW_", { noremap = false })

-- Markdown Preview
-- For Glow, just type :Glow
-- vim.api.nvim_buf_set_keymap(0, "n", ",md", "<Plug>MarkdownPreview", { noremap = false })

-- toggle TS highlighting for markdown
-- vim.api.nvim_buf_set_keymap(0, "n", ",th", "<CMD>TSBufToggle highlight<CR>", { noremap = false })

-- pandoc converter
vim.api.nvim_buf_set_keymap(0, "n", "<leader>mc", "<CMD>call Potraitmd()<CR>", { noremap = false })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>ml", "<CMD>call Landsmd()<CR>", { noremap = false })

-- obsidian

vim.api.nvim_buf_set_keymap(0, "n", "<leader>ff", "<CMD>ObsidianSearch<CR>", { noremap = false })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>fq", "<CMD>ObsidianQuickSwitch<CR>", { noremap = false })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>fb", "<CMD>ObsidianBacklinks<CR>", { noremap = false })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>ft", "<CMD>ObsidianTags<CR>", { noremap = false })

-- vim markdown
vim.api.nvim_buf_set_keymap(0, "n", "<leader>co", "<CMD>Toch<CR>", { noremap = false })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>ci", "<CMD>InsertToc 3<CR>", { noremap = false })

vim.api.nvim_exec(
  [[
" arrows
iabbrev >> →
iabbrev << ←
iabbrev ^^ ↑
iabbrev VV ↓

" eunuch map
nmap <buffer><silent><localleader>rn :Rename<space>

" snippets for markdown
let b:vsnip_snippet_dir = expand('~/.config/nvim/snippets/')
]],
  false
)

-- Persist Markdown Folds
vim.api.nvim_create_augroup("PersistMarkdownFolds", {})
vim.api.nvim_create_autocmd("BufWinLeave", { command = "mkview", pattern = "*.md", group = "PersistMarkdownFolds" })
vim.api.nvim_create_autocmd(
  "BufWinEnter",
  { command = "silent! loadview", pattern = "*.md", group = "PersistMarkdownFolds" }
)

-- match and highlight hyperlinks
-- -- standalone
vim.fn.matchadd("matchURL", [[http[s]\?:\/\/[[:alnum:]%\/_#.-]*]])
vim.cmd "hi matchURL guifg=DodgerBlue"

-- grey out for strikethrough
vim.fn.matchadd("matchStrike", [[[~]\{2}.\+[~]\{2}]])
vim.cmd "hi matchStrike guifg=gray"

-- Setup cmp setup buffer configuration - 👻 text off for markdown
local cmp = require "cmp"
cmp.setup.buffer {
  sources = {
    { name = "vsnip" },
    { name = "spell" },
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          -- @TODOUA: Trying out just populate from visible buffers. Keep?
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
    },
    { name = "path" },
  },
  experimental = {
    ghost_text = false,
  },
}
