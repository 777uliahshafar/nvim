require("obsidian").setup {

  workspaces = {
    {
      name = "personal",
      path = "C:\\Users\\user\\obs",
    },
  },

  picker = {
    name = "telescope.nvim",
  },

  mappings = {
    ["<cr>"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    ["<leader>ch"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    -- ["<cr>"] = {
    --   action = function()
    --     return require("obsidian").util.smart_action()
    --   end,
    --   opts = { buffer = true, expr = true },
    -- },
  },

  ui = {
    checkboxes = {
      [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
      ["x"] = { char = "", hl_group = "ObsidianDone" },
      ["="] = { char = "", hl_group = "GruvboxGray" },
      ["~"] = { char = "", hl_group = "GruvboxOrange" },
      ["!"] = { char = "", hl_group = "ObsidianImportant" },
    },

    bullets = { hl_group = "GruvboxOrange" },
    reference_text = { hl_group = "markdownUrl" },
  },

  templates = {
    subdir = "templates",
    date_format = "%b %d",
    time_format = "%H:%M",
  }, -- end template

  ---@param title string|?
  ---@return string
  note_id_func = function(title)
    local suffix = ""
    if title ~= nil then
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    return tostring(os.time()) .. "-" .. suffix
  end, --end title

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
  end, -- end frontmatter

  -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
  -- URL it will be ignored but you can customize this behavior here.
  ---@param url string
  follow_url_func = function(url)
    -- Open the URL in the default web browser.
    vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
    -- vim.ui.open(url) -- need Neovim 0.10.0+
  end, -- end follow url

  ---@param img string
  follow_img_func = function(img)
    -- vim.fn.jobstart { "qlmanage", "-p", img } -- Mac OS quick look preview
    -- vim.fn.jobstart({"xdg-open", url})  -- linux
    vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
  end, -- end follow img
} -- end setup
