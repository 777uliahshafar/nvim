vim.opt_local.linebreak = true
-- vim.opt_local.conceallevel = 2

local kind_icons = {
  Text = "",
  Snippet = "",
  File = "",
  Interface = "",
  Unit = "",
  Struct = "",
  Event = "",
  Value = "",
  Keyword = "",
  Constant = "",
  Operator = "",
}

require("cmp").setup.buffer {

  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({
        -- nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        path = "[Path]",
        omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
        dictionary = "[Dict]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    -- { name = "nvim_lsp" },
    { name = "luasnip", keyword_length = 2 },
    { name = "path" },
    { name = "omni" },
    { name = "dictionary", keyword_length = 2 }, -- spelllang must be active
  },
}
