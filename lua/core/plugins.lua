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
  {
    "NLKNguyen/papercolor-theme",
  },

  -- Greeter --
  -- {
  --   "goolord/alpha-nvim",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  -- },
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
  "uga-rosa/cmp-dictionary",

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
  },
  "junegunn/limelight.vim", -- dim twilight alternative
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
  "jalvesaq/Nvim-R",

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
  "chentoast/marks.nvim",
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
  -- start of flash
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          local Flash = require "flash"

          ---@param opts Flash.Format
          local function format(opts)
            -- always show first and second label
            return {
              { opts.match.label1, "FlashMatch" },
              { opts.match.label2, "FlashLabel" },
            }
          end

          Flash.jump {
            search = { mode = "search" },

            label = {
              after = false,
              before = { 0, 0 },
              uppercase = false,
              format = format,
            },
            pattern = [[\> ]],
            action = function(match, state)
              state:hide()
              Flash.jump {
                search = { max_length = 0 },
                highlight = { matches = false },
                label = { format = format },
                matcher = function(win)
                  -- limit matches to the current label
                  return vim.tbl_filter(function(m)
                    return m.label == match.label and m.win == win
                  end, state.results)
                end,
                labeler = function(matches)
                  for _, m in ipairs(matches) do
                    m.label = m.label2 -- use the second label
                  end
                end,
              }
            end,
            labeler = function(matches, state)
              local labels = state:labels()
              for m, match in ipairs(matches) do
                match.label1 = labels[math.floor((m - 1) / #labels) + 1]
                match.label2 = labels[(m - 1) % #labels + 1]
                match.label = match.label1
              end
            end,
          }
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  -- end flash
}

local opts = {}
require("lazy").setup(plugins, opts)
