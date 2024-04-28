local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("mason-null-ls").setup {
  ensure_installed = { "stylua", "latexindent", "prettier", "eslint_d" },
  automatic_installation = true,
}

null_ls.setup {
  sources = {
    formatting.stylua,
    formatting.prettier.with {
      filetypes = {
        "html",
        "json",
        "javascript",
        "typescript",
        "css",
        "scss",
        "graphql",
        "yaml",
        "markdown",
        "md",
        "txt",
      },
    },
    require "none-ls.formatting.latexindent", -- requires none-ls-extras.nvim
    require "none-ls.diagnostics.eslint_d",
  },
  -- formatting when saving
  on_attach = function(current_client, bufnr)
    if current_client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format {
            filter = function(client)
              --  only use null-ls for formatting instead of lsp server
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          }
        end,
      })
    end
  end,
}
