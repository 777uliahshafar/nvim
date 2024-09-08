-- mason --
require("mason").setup()

-- mason-lspconfig --
require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "intelephense",
    "jsonls",
    "html",
    "cssls",
    -- "tsserver",
    "emmet_ls",
  },
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

local cmp_nvim_lsp = require "cmp_nvim_lsp"
local capabilities = cmp_nvim_lsp.default_capabilities()
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- lsp-setup
local lspconfig = require "lspconfig"
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
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

lspconfig.intelephense.setup {
  -- requires composer local installation
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
      environment = {
        includePaths = { "/home/mte90/.composer/vendor/php-stubs/", "/home/mte90/.composer/vendor/wpsyntex/" },
      },
      files = {
        maxSize = 5000000,
        associations = { "*.php", "*.phtml", "*.module", "*.inc" },
      },
    },
  },
}
lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

lspconfig.emmet_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
