-- 1. Setup Mason
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "intelephense",
    "jsonls",
    "html",
    "cssls",
    "emmet_ls",
  },
  automatic_installation = true,
}

-- 2. LSP Capabilities & On_Attach
local map = vim.keymap.set
local on_attach = function(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  map("n", "K", vim.lsp.buf.hover, bufopts)
  map("n", "gd", vim.lsp.buf.definition, bufopts)
  map("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Simbol diagnostic
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

---
--- 3. Setup LSP Menggunakan vim.lsp.config (Standar Baru 0.11)
---

-- Server standar tanpa setting rumit
local servers = { "jsonls", "html", "cssls", "emmet_ls" }
for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    install = true, -- Memastikan server terinstal via lspconfig logic
    setup = {
      on_attach = on_attach,
      capabilities = capabilities,
    },
  })
end

-- Konfigurasi KHUSUS Lua
vim.lsp.config("lua_ls", {
  install = true,
  setup = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.stdpath "config" .. "/lua"] = true,
          },
        },
      },
    },
  },
})

-- Konfigurasi KHUSUS Intelephense
vim.lsp.config("intelephense", {
  install = true,
  setup = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      intelephense = {
        stubs = {
          "bcmath",
          "bz2",
          "Core",
          "curl",
          "date",
          "dom",
          "fileinfo",
          "filter",
          "gd",
          "gettext",
          "hash",
          "iconv",
          "imap",
          "intl",
          "json",
          "libxml",
          "mbstring",
          "mcrypt",
          "mysql",
          "mysqli",
          "password",
          "pcntl",
          "pcre",
          "PDO",
          "pdo_mysql",
          "Phar",
          "readline",
          "regex",
          "session",
          "SimpleXML",
          "sockets",
          "sodium",
          "standard",
          "superglobals",
          "tokenizer",
          "xml",
          "xdebug",
          "xmlreader",
          "xmlwriter",
          "yaml",
          "zip",
          "zlib",
          "wordpress-stubs",
          "woocommerce-stubs",
          "acf-pro-stubs",
          "wordpress-globals",
          "wp-cli-stubs",
          "genesis-stubs",
          "polylang-stubs",
        },
        files = {
          maxSize = 5000000,
          associations = { "*.php", "*.phtml", "*.module", "*.inc" },
        },
      },
    },
  },
})
