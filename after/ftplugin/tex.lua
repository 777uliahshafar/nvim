vim.opt_local.conceallevel = 2
vim.opt_local.shiftwidth = 0
vim.opt.updatetime = 1000
vim.opt.swapfile = true
vim.opt.spell = false
vim.opt.spelllang = { "en_us", "id" }
vim.opt.diffopt:append { "followwrap" } -- prevent unwrap gdiffsplit

-- maps
--
vim.api.nvim_buf_set_keymap(0, "n", "<leader>kc", "<plug>(vimtex-compile)", { noremap = false })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>ke", "<plug>(vimtex-errors)", { noremap = false })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>kv", "<plug>(vimtex-view)", { noremap = false })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>ks", "<plug>(vimtex-toggle-main)", { noremap = false })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>kb", "<cmd>h ctb<cr>", { noremap = false, desc = "beamer help" })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>kt", "<cmd>h ct<cr>", { noremap = false, desc = "latex help" })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>j", "<plug>(vimtex-toc-open)", { noremap = false, desc = "TOC" })

-- local kind_icons = {
--   Text = "",
--   Snippet = "",
--   File = "",
--   Interface = "",
--   Unit = "",
--   Struct = "",
--   Event = "",
--   Value = "",
--   Keyword = "",
--   Constant = "",
--   Operator = "",
-- }
--
-- require("cmp").setup.buffer {
--
--   formatting = {
--     format = function(entry, vim_item)
--       vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
--       vim_item.menu = ({
--         -- nvim_lsp = "[LSP]",
--         luasnip = "[Snippet]",
--         path = "[Path]",
--         omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
--         -- dictionary = "[Dict]",
--       })[entry.source.name]
--       return vim_item
--     end,
--   },
--   sources = {
--     -- { name = "nvim_lsp" },
--     { name = "luasnip", keyword_length = 2 },
--     { name = "path" },
--     { name = "omni" },
--     -- { name = "dictionary", keyword_length = 2 }, -- spelllang must be active
--   },
-- }
