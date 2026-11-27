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

return utils
