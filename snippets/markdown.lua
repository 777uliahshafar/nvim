local ls = require "luasnip"
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local sn = ls.snippet_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("markdown", {
  s(
    "file",
    fmt("[{}]({})", {
      i(1, "alt"),
      i(2, "~/"),
    })
  ), --end of snip
}) -- end all

ls.add_snippets("markdown", {
  s(
    "prettier",
    fmt("{}{}", {
      i(1, "<!--prettier-ignore-start-->"),
      i(2, "<!--prettier-ignore-end-->"),
    })
  ), --end of snip
}) -- end all

ls.add_snippets("markdown", {
  s(
    "lip",
    fmt("[{}]({}){}", {
      f(function(_, snip)
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
      i(1, ""),
      i(0, " "),
    })
  ), --end of snip
}) -- end all

ls.add_snippets("markdown", {
  s(
    "sum",
    fmt("<details><summary>...</summary>{}</details>{}", {
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
      i(2, " "),
    })
  ), --end of snip
}) -- end all

ls.add_snippets("markdown", {
  s(
    "bp",
    fmt("**{}**{}", {
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
      i(2, " "),
    })
  ), --end of snip
}) -- end all

ls.add_snippets("markdown", {
  s(
    "ip",
    fmt("*{}*{}", {
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
      i(2, " "),
    })
  ), --end of snip
  s("bb", {
    t { "**" },
    f(function(_, snip)
      -- TM_SELECTED_TEXT is a table to account for multiline-selections.
      -- In this case only the first line is inserted.
      return snip.env.TM_SELECTED_TEXT or {}
    end, {}),
    t { "**" },
    i(0),
  }),

  s("ti", {
    t { "*" },
    f(function(_, snip)
      -- TM_SELECTED_TEXT is a table to account for multiline-selections.
      -- In this case only the first line is inserted.
      return snip.env.TM_SELECTED_TEXT or {}
    end, {}),
    t { "*" },
    i(0),
  }),
}) -- end all
