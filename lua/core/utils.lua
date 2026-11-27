local utils = {}

local scopes = { o = vim.o, b = vim.bo, w = vim.wo }

function utils.opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= "o" then
    scopes["o"][key] = value
  end
end

function utils.map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- utils untuk menutup tab dan buffer lain
function utils.close_other_tabs_and_buffers()
  vim.cmd "tabonly!"

  local visible = {}
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    visible[vim.api.nvim_win_get_buf(win)] = true
  end

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if not visible[buf] then
      pcall(vim.api.nvim_buf_delete, buf, { force = true })
    end
  end
end

-- utils untuk membuka tab sebelah kanan menjadi vertical split tanpa menutup tabnya
function utils.merge_next_tab_vsplit()
  local current_tab = vim.api.nvim_get_current_tabpage()
  local tabs = vim.api.nvim_list_tabpages()

  local current_idx
  for i, t in ipairs(tabs) do
    if t == current_tab then
      current_idx = i
      break
    end
  end

  if current_idx and tabs[current_idx + 1] then
    local next_tab = tabs[current_idx + 1]
    local next_win = vim.api.nvim_tabpage_get_win(next_tab)
    local next_buf = vim.api.nvim_win_get_buf(next_win)

    vim.cmd "vsplit"
    vim.api.nvim_win_set_buf(0, next_buf)
  else
    vim.notify("Tidak ada tab di sebelah kanan.", vim.log.levels.WARN)
  end
end

vim.api.nvim_create_user_command("Vt", utils.merge_next_tab_vsplit, {
  desc = "Buka tab sebelah kanan sebagai vertical split tanpa menutupnya",
})

-- utils untuk menutup buffer No Name / tanpa file selain buffer aktif
function utils.close_unnamed_buffers()
  local current_buf = vim.api.nvim_get_current_buf()

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) then
      local name = vim.api.nvim_buf_get_name(buf)
      local buftype = vim.bo[buf].buftype

      -- Cek jika nama buffer kosong ([No Name]) dan merupakan buffer normal (bukan terminal/plugin sidebar)
      if name == "" and buftype == "" then
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end
    end
  end
end

return utils
