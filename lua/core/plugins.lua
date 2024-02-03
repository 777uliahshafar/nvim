local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- Telescope --
  {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.0",
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
  "nvim-telescope/telescope-file-browser.nvim",
  "nvim-telescope/telescope-ui-select.nvim",

  -- Syntax
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      pcall(require("nvim-treesitter.install").update { with_sync = true })
    end,
    dependencies = { { "nvim-treesitter/nvim-treesitter-textobjects" } },
  },
  -- LSP --
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
  },
  "williamboman/mason-lspconfig.nvim",
  "jay-babu/mason-null-ls.nvim",
  "neovim/nvim-lspconfig",
  "jose-elias-alvarez/null-ls.nvim",

  -- Completion --
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-omni",
  "uga-rosa/cmp-dictionary",
  "hrsh7th/cmp-nvim-lsp",
  "saadparwaiz1/cmp_luasnip",

  -- Issues --
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end,
  },
  -- Snippet --
  {
    "L3MON4D3/LuaSnip",
    dependencies = { { "rafamadriz/friendly-snippets", lazy = true } },
  },

  -- Status line --
  "nvim-lualine/lualine.nvim",
  -- File management --
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { { "nvim-tree/nvim-web-devicons", lazy = true } },
  },

  -- zen mode--
  {
    "folke/zen-mode.nvim",
    dependencies = {
      {
        "folke/twilight.nvim",
        lazy = true,
        opts = {
          dimming = { alpha = 0.15 },
          context = 7,
          treesitter = true,
          exclude = { "bib", "norg" },
        },
      },
    },
  },

  "chentoast/marks.nvim",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Tim Pope Plugins --
  "tpope/vim-surround",
  "tpope/vim-fugitive",

  -- Colorscheme --
  --
  {
    "777uliahshafar/mygruvbox.nvim",
    priority = 1000,
  },

  -- Writing
  { "lervag/vimtex", lazy = false },
  { "andymass/vim-matchup", lazy = false },
  {
    "andrewferrier/wrapping.nvim",
    config = function()
      require("wrapping").setup {
        auto_set_mode_filetype_allowlist = {
          "text",
        },
      }
    end,
  },
  "ron89/thesaurus_query.vim",
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
  },
  -- {
  --   "nvim-neorg/neorg",
  --   -- tag = "v5.0.0",
  --   build = ":Neorg sync-parsers",
  --   dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
  -- },
  "jalvesaq/Nvim-R",
  "777uliahshafar/vim-myhelp",
}

local opts = {}
require("lazy").setup(plugins, opts)
