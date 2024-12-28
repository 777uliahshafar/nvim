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
  -- Colorscheme --
  {
    "777uliahshafar/mygruvbox.nvim",
    priority = 1000,
  },
  { "zootedb0t/citruszest.nvim", priority = 1000 },
  { "rebelot/kanagawa.nvim", priority = 1000 },
  { "savq/melange-nvim" },

  -- Greeter --
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- Telescope --
  {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.0",
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
  "nvim-telescope/telescope-file-browser.nvim",
  "nvim-telescope/telescope-ui-select.nvim",
  -- Syntax --
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
  "neovim/nvim-lspconfig",
  -- lsp,linter,formating --
  "jay-babu/mason-null-ls.nvim",
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
  },
  -- "jose-elias-alvarez/null-ls.nvim",
  -- Completion --
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-omni",
  "hrsh7th/cmp-nvim-lsp",
  "saadparwaiz1/cmp_luasnip",
  -- "uga-rosa/cmp-dictionary",

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
          exclude = { "bib", "md" },
        },
      },
    },
  },
  -- Tim Pope Plugins --
  "tpope/vim-fugitive",
  -- "tpope/vim-surround",
  -- Writing --
  { "lervag/vimtex", lazy = false },
  { "andymass/vim-matchup", lazy = false },
  {
    "andrewferrier/wrapping.nvim",
    config = function()
      require("wrapping").setup {
        auto_set_mode_filetype_allowlist = {},
      }
    end,
  },
  "dhruvasagar/vim-table-mode",
  -- "junegunn/vim-easy-align",
  "ron89/thesaurus_query.vim",
  "potamides/pantran.nvim",
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      -- "folke/trouble.nvim",
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "telescope.nvim",
    },
  },
  "preservim/vim-markdown",
  -- "jalvesaq/Nvim-R",

  -- utility --
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  -- {
  --   "shellRaining/hlchunk.nvim",
  --   event = { "UIEnter" },
  -- },
  -- {
  --   "kylechui/nvim-surround",
  --   version = "*", -- Use for stability; omit to use `main` branch for the latest features
  --   event = "VeryLazy",
  --   config = function()
  --     require("nvim-surround").setup {}
  --   end,
  -- },
  -- "chentoast/marks.nvim",
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- {
  --   "folke/trouble.nvim",
  --   config = function()
  --     require("trouble").setup()
  --   end,
  -- },
  "777uliahshafar/vim-myhelp",
  "ton/vim-bufsurf",
}

local opts = {}
require("lazy").setup(plugins, opts)
