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
      i(2, "/"),
    })
  ), --end of snip
}) -- end all
