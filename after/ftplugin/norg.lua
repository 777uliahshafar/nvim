vim.opt_local.linebreak = true
-- vim.opt_local.conceallevel = 2

require("cmp").setup.buffer {
  sources = {
    { name = "luasnip" },
    { name = "path" },
    { name = "neorg" },
  },
}
