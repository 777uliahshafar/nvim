local g = vim.g

-- reduce lag on matching paren
-- g.vimtex_matchparen_enabled = false
g.matchup_override_vimtex = true
g.matchup_matchparen_deferred = true

-- folding
g.vimtex_fold_enabled = true
g.vimtex_fold_types = {
  comments = { enabled = true },
}

g.vimtex_syntax_nospell_comments = true

-- change defaul compiler engine
g.vimtex_compiler_latexmk_engines = {
  _ = "-lualatex",
}

g.vimtex_compiler_latexmk = {
  options = {
    "-shell-escape",
    "-verbose",
    "-file-line-error",
    "-synctex=1",
    "-interaction=nonstopmode",
  },
}

-- /// sumatra
-- g.vimtex_view_general_viewer = "SumatraPDF"
-- g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
-- /// sioyek
g.vimtex_view_method = "sioyek"
-- /// okular
-- vim.g.vimtex_view_general_viewer = "okular"
-- vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"

-- warning errors
g.vimtex_quickfix_mode = 0
g.vimtex_log_ignore = {
  "Underfull",
  "Overfull",
  "specifier changed to",
  "Token not allowed in a PDF string",
}

-- maps
vim.api.nvim_buf_set_keymap(0, "n", "<leader>lc", "<plug>(vimtex-compile)", { noremap = false })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>le", "<plug>(vimtex-errors)", { noremap = false })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>lv", "<plug>(vimtex-view)", { noremap = false })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>ls", "<plug>(vimtex-toggle-main)", { noremap = false })
vim.api.nvim_buf_set_keymap(0, "n", "<leader>co", "<plug>(vimtex-toc-open)", { noremap = false })
