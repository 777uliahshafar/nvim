local ls = require "luasnip"
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local sn = ls.snippet_node
local f = ls.function_node
local c = ls.choice_node
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
  ), --end of snip

  s(
    "posp",
    fmt("\\begin{{textblock*}}{{{}}}({}){}\\end{{textblock*}}", {
      i(1, "50mm"),
      i(2, "95mm,130mm"),
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ), --end of snip
  s(
    "ovop",
    fmt("\\only<{}>{{{}}}", {
      i(1, "1-"),
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ), --end of snip
  s(
    "ovsp",
    fmt("\\onslide<{}>{{{}}}", {
      i(1, "1-"),
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ), --end of snip
  s(
    "notep",
    fmt("\\notes{{{}}}", {
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ), --end of snip
  s(
    "frame",
    fmt(
      [[
    \begin{{frame}}[{},mybg={},mytitle={},{}{}]%rmve mycolor when use mybg\\labelonfirst
    \frametitle{{{}}}
    {}
    \end{{frame}}]],
      {
        i(1, "t"),
        c(2, { t "placeholder", t "" }),
        c(3, { t "standard", t "imageplus", t "center" }),
        c(4, { t "mycolor=digiPH_gray,", t "mycolor=digiPH_leaf,", t "mycolor=digiPH_ocean,", t "" }),
        c(5, { t "light", t "dark" }),
        i(6, "notitle"),
        i(7, "content"),
      }
    )
  ), --end of snip
  s(
    "img",
    fmt("\\includegraphics[{}width={}]{{{}}}", {
      c(1, { t "", t "draft," }),
      c(2, { t "40mm", t ".9\\textwidth" }),
      i(3, "placeholder"),
    })
  ), --end of snip
}) -- end all
