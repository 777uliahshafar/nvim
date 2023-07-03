local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- Telescope --
    {
        "nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    	"nvim-telescope/telescope-file-browser.nvim",

    -- Syntax 
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            pcall(require("nvim-treesitter.install").update{ with_sync = true })
        end,
		dependencies = { { "nvim-treesitter/nvim-treesitter-textobjects" } },
    },
    -- Completion -- 
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "uga-rosa/cmp-dictionary",
        "saadparwaiz1/cmp_luasnip",
    -- Snippet --
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",

        "folke/which-key.nvim",
    -- Status line --
        "nvim-lualine/lualine.nvim",
    -- File management --
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { { "nvim-tree/nvim-web-devicons", lazy = true } },
    },
    -- Tim Pope Plugins --
	"tpope/vim-surround",

    -- Colorscheme --
    {
    "folke/tokyonight.nvim",
    lazy = false,     
    priority = 1000,     
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
    },

    -- Writing
    {"lervag/vimtex",
    lazy = false,     
    },
}


local opts = {}
require("lazy").setup(plugins, opts)


