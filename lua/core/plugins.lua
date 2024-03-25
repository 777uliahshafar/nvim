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
  -- greeter --
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local startify = require "alpha.themes.startify"
      startify.section.header.val = {
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⣠⣼⣿⡟⠉⠛⣿⣾⣿⣮⣯⣥⡶⢿⣯⢛⡟⣴⡿⢶⣥⣤⣶⣿⣵⣿⠛⠛⠿⢿⣤⡀⠂⣉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⣼⢟⡿⠋⠀⠀⠀⣠⣤⠀⠀⠀⠙⠛⢢⣧⠊⠉⣜⡔⠛⠃⠀⠀⠠⣤⡀⠀⠀⠀⠻⣿⠹⡆⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡜⣧⠠⠤⢀⡴⣻⠄⢀⠠⡀⢀⣠⣷⠋⠀⠀⠘⢶⣄⡀⡄⠀⠀⢠⡝⣄⠀⡤⢀⡼⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣷⣿⣷⣼⣠⣜⣿⣾⠁⠀⠀⠀⠀⠀⣿⣯⣓⣛⣁⣼⣿⣾⣿⣿⣿⣤⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠘⡿⣿⣿⢿⣾⣿⣿⣏⠙⠻⣿⣿⣯⣀⢀⣠⢄⡀⢂⣿⣿⡿⠋⠉⢙⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢁⠈⠙⠉⠉⠉⢹⡆⡾⢸⣿⣿⠿⣿⣿⣿⣯⣍⠀⣡⢰⡏⠉⠉⠛⠉⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣄⠀⠀⠀⠀⡾⡰⣿⣿⢿⡿⣦⣿⣽⢿⢻⡟⢳⣽⣎⡧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⣸⡆⠀⠀⠉⢠⣦⣾⣀⣾⡇⠑⠀⠀⣤⡀⠉⣾⠀⠀⣸⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
      }
      startify.section.top_buttons.val = {
        startify.button("e", " > New File", "<cmd>ene<CR>"),
        startify.button("SPC pff", " > Find File", "<cmd>Telescope find_files<CR>"),
        startify.button("SPC pfw", " > Find Word", "<cmd>Telescope live_grep<CR>"),
      }

      require("alpha").setup(startify.config)
    end,
  },
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
  -- "uga-rosa/cmp-dictionary",
  "hrsh7th/cmp-nvim-lsp",
  "saadparwaiz1/cmp_luasnip",

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
  -- Tim Pope Plugins --
  -- "tpope/vim-surround",
  "tpope/vim-fugitive",
  -- Colorscheme --
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
        auto_set_mode_filetype_allowlist = {},
      }
    end,
  },
  "junegunn/vim-easy-align",
  "ron89/thesaurus_query.vim",
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      -- "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
      "telescope.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "C:\\Users\\uliah\\obs",
        },
      },
      picker = {
        name = "telescope.nvim",
      },
      mappings = {
        ["fo"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
      },
      ui = {
        checkboxes = {
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["="] = { char = "", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        },
      },
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
      }, -- end template
      note_frontmatter_func = function(note)
        -- This is equivalent to the default frontmatter function.
        local out = { id = note.id, aliases = note.aliases, tags = note.tags, links = "" }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,

      -- see below for full list of options 👇
    },
  },
  "preservim/vim-markdown",
  -- "jalvesaq/Nvim-R",
  -- utility --
  -- "chentoast/marks.nvim",
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
  },
  "777uliahshafar/vim-myhelp",
}

local opts = {}
require("lazy").setup(plugins, opts)
