local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

-- local hlmap = vim.treesitter.TSHighlighter.hl_map

configs.setup {
  ensure_installed = { "json", "lua", "vimdoc", "markdown", "markdown_inline", "latex", "javascript" }, -- one of "all" or a list of languages
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "latex" }, -- list of language that will be disabled
  },
  indent = { enable = true, disable = { "python", "css" } },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
  },
}
