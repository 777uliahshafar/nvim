local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local keymap = vim.keymap -- for conciseness

local on_attach = function(_, bufnr)
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  keymap.set("n", "<leader>d", vim.diagnostic.open_float, bufopts)
  keymap.set("n", "<leader>k", vim.lsp.buf.hover, bufopts)
  keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
end

local capabilities = cmp_nvim_lsp.default_capabilities()

local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

lspconfig["lua_ls"].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = { -- custom settings for lua
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

lspconfig["eslint"].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig["html"].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig["jsonls"].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig["tailwindcss"].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig["tsserver"].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
}

-- lspconfig["texlab"].setup {
--   capabilities = capabilities,
--   on_attach = on_attach,
-- }
