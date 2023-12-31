-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

-- local opt = vim.opt
-- local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- rm empty line
autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- clear msg in cmdline
autocmd({ "CursorHold" }, {
  pattern = { "*" },
  command = [[echon ""]],
})

-- close quickfix menu after selecting choice
autocmd("FileType", {
  pattern = { "qf" },
  command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]],
})

-- wrap preview telescope
autocmd("User", {
  pattern = { "TelescopePreviewerLoaded" },
  command = "setlocal wrap",
})
