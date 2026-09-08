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
  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    -- config = function()
    --     vim.g.zenbones_darken_comments = 45
    --     vim.cmd.colorscheme('zenbones')
    -- end
  },
  -- { "zootedb0t/citruszest.nvim", priority = 1000 },
  { "rebelot/kanagawa.nvim", priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "EdenEast/nightfox.nvim" },
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("onedark").setup {
        style = "darker",
        colors = {
          light_grey = "#e6eaea",
        },
        highlights = {
          normal = { fg = "#e6eaea" },
          ObsidianTag = { fg = "#00ffaa", sp = "#00ffaa", fmt = "underline,italic" },
        },
      }
      require("onedark").load()
    end,
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
  -- :Mason
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
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
  -- AI Agent
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
  -- {
  --   "kiddos/gemini.nvim",
  --   opts = {},
  -- },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    -- `cmd` lets lazy.nvim create command stubs that load the plugin on first use,
    -- so `:ClaudeCode` and friends work on a fresh start. Without it, a keys-only
    -- spec defers loading until a <leader>a* mapping is pressed and the commands
    -- would not exist yet.
    cmd = {
      "ClaudeCode",
      "ClaudeCodeFocus",
      "ClaudeCodeSelectModel",
      "ClaudeCodeAdd",
      "ClaudeCodeSend",
      "ClaudeCodeTreeAdd",
      "ClaudeCodeStatus",
      "ClaudeCodeStart",
      "ClaudeCodeStop",
      "ClaudeCodeOpen",
      "ClaudeCodeClose",
      "ClaudeCodeDiffAccept",
      "ClaudeCodeDiffDeny",
      "ClaudeCodeCloseAllDiffs",
    },
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
  -- end AI agent
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "telescope.nvim",
    },
  },
  "preservim/vim-markdown",
  -- install with yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  }, -- require node.js & npm
  -- "jalvesaq/Nvim-R",
  -- utility --
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
  },
  {
    "nvim-mini/mini.comment",
    version = "*",
    config = function()
      require("mini.comment").setup()
    end,
  },
  -- {
  --   "shellRaining/hlchunk.nvim",
  --   event = { "UIEnter" },
  -- },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
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
