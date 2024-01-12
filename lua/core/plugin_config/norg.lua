require("neorg").setup {
  load = {
    ["core.defaults"] = {
      config = {
        disable = {
          "core.autocommands",
          "core.itero",
        },
      },
    }, -- Loads default behaviour
    ["core.concealer"] = {
      config = {
        icons = {
          code_block = { false },
          definition = { false },
          delimiter = { false },
          footnote = { false },
          heading = { false },
          list = { false },
          markup = { false },
          ordered = { false },
          quote = { false },
          todo = {
            done = { icon = "󱎖" },
            pending = { icon = "✓" },
            undone = { icon = " " },
          },
        },
      },
    },
    ["core.qol.todo_items"] = {
      config = {},
    },
    ["core.dirman"] = { -- Manages Neorg workspaces
      config = {
        workspaces = {
          main = "~/notes/main",
        },
        default_workspace = "main",
      },
    },
    ["core.highlights"] = {
      config = {
        highlights = {
          anchors = {
            declaration = "+Underlined",
          },
          headings = {
            ["1"] = {
              prefix = "+@storageclass",
              title = "+@storageclass",
            },
            ["2"] = {
              prefix = "+@type.definition",
              title = "+@type.definition",
            },
            ["3"] = {
              prefix = "+@attribute",
              title = "+@attribute",
            },
            ["4"] = {
              prefix = "+@constant",
              title = "+@constant",
            },
          },
          links = {
            description = "+@text.uri",
            file = "+@string",
            location = {
              url = "+@string",
            },
          },
          todo_items = {
            pending = "+@punctuation.delimiter",
            undone = "+@punctuation.delimiter",
            done = "+@punctuation.delimiter",
            on_hold = "+@punctuation.delimiter",
          },
        },
      },
    },
    ["core.integrations.telescope"] = {},
    ["core.integrations.treesitter"] = {},
    ["core.integrations.nvim-cmp"] = {},
    ["core.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.summary"] = {},
    ["core.esupports.metagen"] = {
      config = {
        tab = "  ",
        template = {
          {
            "title",
            function()
              return vim.fn.expand "%:t:r"
              -- return vim.fn.expand "%:t:r:S" -- with apostrophe
            end,
          },
          {
            "date",
            function()
              return os.date "%Y-%m-%d"
              -- return os.date '"%Y-%m-%d"' -- with apostrophe
            end,
          },
          { "tags", "" },
          { "categories", "" },
        },
      },
    },
    ["core.keybinds"] = {
      config = {
        hook = function(keybinds)
          keybinds.remap_event("norg", "n", "<Tab>", "core.integrations.treesitter.next.heading")
          keybinds.remap_event("norg", "n", "<S-Tab>", "core.integrations.treesitter.previous.heading")
          keybinds.remap_event("norg", "n", "<leader>s", "core.integrations.telescope.find_linkable")
          keybinds.remap_event("norg", "i", "<c-s>", "core.integrations.telescope.insert_link")
          keybinds.remap_event("norg", "n", "<leader>v", "core.qol.todo_items.todo.task_cycle")
          keybinds.map("norg", "n", "<leader>ll", "<cmd>Neorg toc qflist<CR>")
          keybinds.map("norg", "n", "<leader>lc", "<cmd>Neorg presenter start<CR>")
          keybinds.map("norg", "n", "<leader>ls", "<cmd>Neorg generate-workspace-summary<CR>")
          keybinds.map("norg", "n", "<BS>", "<c-6>")
          keybinds.map("norg", "n", "<leader>d", "i<C-R>=strftime(' %m-%d')<CR><ESC>")
        end,
      },
    },
  },
}
