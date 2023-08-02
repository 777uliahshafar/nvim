vim.opt_local.conceallevel = 2
vim.opt_local.shiftwidth = 0
vim.opt.updatetime = 1000
vim.opt.swapfile = true

local kind_icons = {
  Text = "",
  Snippet = "",
  File = "󰔱",
}

require("cmp").setup.buffer {

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        path = "[Path]",
        omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip", keyword_length = 2 },
    { name = "path" },
    { name = "omni" },
  },
}
