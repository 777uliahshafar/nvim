-- mason --
require("mason").setup()

-- mason-lspconfig --
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls" },
  automatic_installation = true,
}

-- nvim-lspconfig --
-- keybinding-config
local map = vim.keymap.set
local on_attach = function(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map("n", "K", vim.lsp.buf.hover, bufopts)
  map("n", "gd", vim.lsp.buf.definition, bufopts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  -- map("n", "gD", vim.lsp.buf.declaration, bufopts)
  -- map("n", "<leader>d", vim.diagnostic.open_float, bufopts)
  -- map("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  -- map("n", "gi", vim.lsp.buf.implementation, bufopts)
end

-- local capabilities = cmp_nvim_lsp.default_capabilities()
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- lsp-setup
local lspconfig = require "lspconfig"
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
  settings = {
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  },
}
