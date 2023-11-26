local ls = require "luasnip"
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local sn = ls.snippet_node
local f = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("tex", {
  s(
    "boxp",
    fmt("\\boxes{{{}}}{{{}}}{{{}}}", {
      i(1, "digiPH_gray"),
      i(2, "digiPH_writer"),
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ),
}) -- end all