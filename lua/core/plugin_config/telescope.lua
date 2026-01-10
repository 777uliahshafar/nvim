local all_ok, telescope, themes, builtin, actions = pcall(function()
  return require "telescope", require "telescope.themes", require "telescope.builtin", require "telescope.actions"
end)

if not all_ok then
  return
end

telescope.setup {
  defaults = {
    wrap_results = true,
    prompt_prefix = " ",
    selection_caret = " ",
    -- path_display = { "shorten" },
    path_display = function(opts, path)
      local tail = require("telescope.utils").path_tail(path)
      return string.format("%s (%s)", tail, path), { { { 1, #tail }, "Constant" } }
    end,
    layout_config = {
      prompt_position = "bottom",
      horizontal = {
        width_padding = 0.04,
        height_padding = 0.1,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.8,
      },
    },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<Tab>"] = actions.move_selection_next,
        ["<S-Tab>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<C-j>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<C-k>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
      },
    },
  },
  pickers = {
    live_grep = {
      theme = "dropdown",
    },
  },
  extensions = {
    ["ui-select"] = {
      themes.get_dropdown(),
    },
  },
}
telescope.load_extension "ui-select"

local bufopts = { noremap = true, silent = true }
-- vim.keymap.set("n", "gd", function()
--   builtin.lsp_definitions()
-- end, bufopts)
-- vim.keymap.set("n", "gf", function()
--   builtin.lsp_type_definitions()
-- end, bufopts)
-- vim.keymap.set("n", "gR", function()
--   builtin.lsp_references()
-- end, bufopts)
vim.keymap.set("n", "<leader>*", function()
  builtin.grep_string()
end, bufopts)
-- vim.keymap.set("n", "<leader>gs", function()
--   builtin.git_status()
-- end, bufopts)
-- vim.keymap.set("n", "<leader>gt", function()
--   builtin.git_stash()
-- end, bufopts)
-- vim.keymap.set("n", "<leader>gb", function()
--   builtin.git_branches()
-- end, bufopts)
-- vim.keymap.set("n", "<leader>gc", function()
--   builtin.git_commits()
-- end, bufopts)
-- vim.keymap.set("n", "<leader>gbc", function()
--   builtin.git_bcommits()
-- end, bufopts)
-- vim.keymap.set("n", '<leader>"', function()
--   builtin.registers()
-- end, bufopts)
-- vim.keymap.set("n", "<leader>ff", function()
-- builtin.find_files()
-- end, bufopts)
-- vim.keymap.set("n", "<leader>fw", function()
-- builtin.live_grep()
-- end, bufopts)
-- vim.keymap.set("n", "<leader>fb", function()
--   builtin.buffers()
-- end, bufopts)
-- vim.keymap.set("n", "<leader>fr", function()
--   builtin.oldfiles()
-- end, bufopts)
