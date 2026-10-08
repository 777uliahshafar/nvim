local harpoon = require("harpoon")

-- =========================================================
-- HARPOON V2
-- GLOBAL LIST
-- =========================================================

harpoon:setup({
  settings = {
    -- Semua project / folder / drive menggunakan list yang sama
    key = function()
      return "global"
    end,

    save_on_change = true,
    save_on_toggle = false,
    sync_on_ui_close = false,

    enter_on_sendcmd = false,
    tmux_autoclose_windows = false,

    excluded_filetypes = {
      "harpoon",
    },

    mark_branch = false,
    tabline = false,
    tabline_prefix = "   ",
    tabline_suffix = "   ",
  },

  default = {

    -- =====================================================
    -- CREATE LIST ITEM
    -- =====================================================

    create_list_item = function(config, name)
      name = name or vim.api.nvim_buf_get_name(
        vim.api.nvim_get_current_buf()
      )

      -- Selalu simpan absolute path
      name = vim.fn.fnamemodify(name, ":p")

      local bufnr = vim.fn.bufnr(name, false)
      local pos = { 1, 0 }

      if bufnr ~= -1 then
        pos = vim.api.nvim_win_get_cursor(0)
      end

      return {
        value = name,

        context = {
          row = pos[1],
          col = pos[2],
        },
      }
    end,

    -- =====================================================
    -- SELECT / OPEN FILE
    -- =====================================================

    select = function(list_item, list, options)
      local path = list_item.value

      -- Buka file secara langsung.
      -- fnameescape aman untuk path Windows.
      vim.cmd(
        "silent keepjumps edit "
          .. vim.fn.fnameescape(path)
      )

      -- Kembalikan posisi cursor
      if list_item.context then
        pcall(
          vim.api.nvim_win_set_cursor,
          0,
          {
            list_item.context.row or 1,
            list_item.context.col or 0,
          }
        )
      end
    end,

    -- Jangan gunakan BufLeave bawaan Harpoon
    autocmds = {},
  },
})


-- =========================================================
-- PREVIOUS / NEXT
-- =========================================================

vim.keymap.set("n", "<leader>h", function()
  harpoon:list():prev({
    ui_nav_wrap = true,
  })
end, {
  desc = "harpoon prev",
})

vim.keymap.set("n", "<leader>l", function()
  harpoon:list():next({
    ui_nav_wrap = true,
  })
end, {
  desc = "harpoon next",
})


-- =========================================================
-- ADD / DELETE
-- =========================================================

vim.keymap.set("n", "<leader>sa", function()
  harpoon:list():add()
end, {
  desc = "harpoon add file",
})

vim.keymap.set("n", "<leader>sd", function()
  harpoon:list():remove()
end, {
  desc = "harpoon delete mark",
})


-- =========================================================
-- SELECT 1 - 4
-- =========================================================

vim.keymap.set("n", "<localleader>sh", function()
  harpoon:list():select(1)
end, {
  desc = "harpoon 1",
})

vim.keymap.set("n", "<localleader>sj", function()
  harpoon:list():select(2)
end, {
  desc = "harpoon 2",
})

vim.keymap.set("n", "<localleader>sk", function()
  harpoon:list():select(3)
end, {
  desc = "harpoon 3",
})

vim.keymap.set("n", "<localleader>sl", function()
  harpoon:list():select(4)
end, {
  desc = "harpoon 4",
})


-- =========================================================
-- HARPOON BUILT-IN MENU
-- =========================================================

vim.keymap.set("n", "<leader>ss", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, {
  desc = "Harpoon menu",
})


