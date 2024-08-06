require("obsidian").setup {

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
    -- ["fo"] = {
    --   action = function()
    --     return require("obsidian").util.gf_passthrough()
    --   end,
    --   opts = { noremap = false, expr = true, buffer = true },
    -- },
    -- ["<leader>ch"] = {
    --   action = function()
    --     return require("obsidian").util.toggle_checkbox()
    --   end,
    --   opts = { buffer = true },
    -- },
    ["<cr>"] = {
      action = function()
        return require("obsidian").util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    },
  },

  ui = {
    checkboxes = {
      [" "] = { char = "󰄱", hl_group = "GruvboxFg7" },
      ["="] = { char = "󱎖", hl_group = "GruvboxGreen" },
      ["x"] = { char = "", hl_group = "GruvboxForest" },
      [">"] = { char = "󰁕", hl_group = "GruvboxAqua" },
      ["~"] = { char = "󱫪", hl_group = "GruvboxRed" },
      ["/"] = { char = "", hl_group = "GruvboxYellow" },
    },

    bullets = { hl_group = "GruvboxOrange" },
    reference_text = { hl_group = "markdownUrl" },
  },

  templates = {
    subdir = "templates",
    date_format = "%b %d",
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
} -- end setup
