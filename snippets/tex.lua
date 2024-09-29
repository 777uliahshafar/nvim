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
local rec_item
local rec_itemly

rec_item = function()
  return sn(nil, {
    c(1, {
      -- important!! Having the sn(...) as the first choice will cause infinite recursion.
      t { "" },
      -- The same dynamicNode as in the snippet (also note: self reference).
      sn(nil, { t { "", "\t\\item " }, i(1), d(2, rec_item, {}) }),
    }),
  })
end

rec_itemly = function()
  return sn(nil, {
    c(1, {
      -- important!! Having the sn(...) as the first choice will cause infinite recursion.
      t { "" },
      -- The same dynamicNode as in the snippet (also note: self reference).
      sn(nil, {
        t { "", "\t\\item<" },
        i(1, ""),
        t { "-> " },
        i(2),
        d(3, rec_itemly, {}),
      }),
    }),
  })
end

ls.add_snippets("tex", {
  s(
    "txtp",
    fmt("\\txt{}{{{}}}", {
      c(1, {
        t "{digiPH_gray}{digiPH_black}",
        t "{digiPH_white}{digiPH_black}",
        t "{digiPH_leaf}{digiPH_white}",
        t "{digiPH_ocean}{digiPH_white}",
        t "{digiPH_ocean}{digiPH_blue}",
        t "{digiPH_red}{digiPH_white}",
        t "{digiPH_gray}{digiPH_darkblue}",
      }),
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ), --end of snip

  s(
    "txt",
    fmt("\\txt{}{{{}}}", {
      c(1, {
        t "{digiPH_gray}{digiPH_black}",
        t "{digiPH_white}{digiPH_black}",
        t "{digiPH_leaf}{digiPH_white}",
        t "{digiPH_ocean}{digiPH_white}",
        t "{digiPH_ocean}{digiPH_blue}",
        t "{digiPH_red}{digiPH_white}",
        t "{digiPH_gray}{digiPH_darkblue}",
      }),
      i(3, ""),
    })
  ), --end of snip

  s(
    "txtleft",
    fmt("\\ltxt{}{{{}}}", {
      c(1, {
        t "{digiPH_gray}{digiPH_black}",
        t "{digiPH_white}{digiPH_black}",
        t "{digiPH_leaf}{digiPH_white}",
        t "{digiPH_ocean}{digiPH_white}",
        t "{digiPH_ocean}{digiPH_blue}",
        t "{digiPH_red}{digiPH_white}",
        t "{digiPH_gray}{digiPH_darkblue}",
      }),
      i(3, ""),
    })
  ), --end of snip

  s(
    "txtright",
    fmt("\\rtxt{}{{{}}}", {
      c(1, {
        t "{digiPH_gray}{digiPH_black}",
        t "{digiPH_white}{digiPH_black}",
        t "{digiPH_leaf}{digiPH_white}",
        t "{digiPH_ocean}{digiPH_white}",
        t "{digiPH_ocean}{digiPH_blue}",
        t "{digiPH_red}{digiPH_white}",
        t "{digiPH_gray}{digiPH_darkblue}",
      }),
      i(3, ""),
    })
  ), --end of snip

  s(
    "txtup",
    fmt("\\utxt{}{{{}}}", {
      c(1, {
        t "{digiPH_gray}{digiPH_black}",
        t "{digiPH_white}{digiPH_black}",
        t "{digiPH_leaf}{digiPH_white}",
        t "{digiPH_ocean}{digiPH_white}",
        t "{digiPH_ocean}{digiPH_blue}",
        t "{digiPH_red}{digiPH_white}",
        t "{digiPH_gray}{digiPH_darkblue}",
      }),
      i(2, ""),
    })
  ), --end of snip

  s(
    "txtbot",
    fmt("\\btxt{}{{{}}}", {
      c(1, {
        t "{digiPH_gray}{digiPH_black}",
        t "{digiPH_white}{digiPH_black}",
        t "{digiPH_leaf}{digiPH_white}",
        t "{digiPH_ocean}{digiPH_white}",
        t "{digiPH_ocean}{digiPH_blue}",
        t "{digiPH_red}{digiPH_white}",
        t "{digiPH_gray}{digiPH_darkblue}",
      }),
      i(3, ""),
    })
  ), --end of snip

  s(
    "blkp",
    fmt("\\begin{{textblock*}}{{{}mm}}({}mm,{}mm){}\\end{{textblock*}}", {
      i(1, "50"),
      i(2, "130"),
      i(3, "95"),
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ), --end of snip

  s(
    "blk",
    fmt("\\begin{{textblock*}}{{{}mm}}({}mm,{}mm){}\\end{{textblock*}}", {
      i(1, "50"),
      i(2, "130"),
      i(3, "95"),
      i(4, ""),
    })
  ), --end of snip

  s(
    "onlp",
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
    "onsp",
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
    "nop",
    fmt("\\notes{{{}}}", {
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ), --end of snip
  s(
    "fm",
    fmt(
      [[
    \begin{{frame}}[{}]
    \frametitle{{{}}}
    ]],
      {
        c(1, {
          t "t,mybg=darkbg,mytitle=standard,dark",
          t "t,mybg=lightbg,mytitle=standard,light",
          t "t,mycolor=digiPH_gray,mytitle=standard,light",
          t "t,mycolor=digiPH_leaf,mytitle=standard,dark",
          t "t,mycolor=digiPH_ocean,mytitle=center,dark",
          t "t,mycolor=digiPH_red,mytitle=standard,dark",
        }),
        i(6, "untitled"),
      }
    )
  ), --end of snip

  s("ft", {
    t { "\\frametitle{" },
    f(function(_, snip)
      -- TM_SELECTED_TEXT is a table to account for multiline-selections.
      -- In this case only the first line is inserted.
      return snip.env.TM_SELECTED_TEXT or {}
    end, {}),
    t { "} " },
    i(0),
  }), --end of snip

  s("fs", {
    t { "\\framesubtitle{" },
    f(function(_, snip)
      -- TM_SELECTED_TEXT is a table to account for multiline-selections.
      -- In this case only the first line is inserted.
      return snip.env.TM_SELECTED_TEXT or {}
    end, {}),
    t { "} " },
    i(0),
  }), --end of snip

  s(
    "img",
    fmt("\\includegraphics[{}width={}]{{{}}}", {
      c(1, { t "", t "draft," }),
      c(2, { t "40mm", t ".9\\textwidth" }),
      i(3, "placeholder"),
    })
  ), --end of snip

  s(
    "subfile",
    fmt("\\subfile{{subfiles/{}.tex}}", {
      i(1, "filename"),
    })
  ), --end of snip

  s("item", {
    t { "\t\\item " },
    i(1),
    d(2, rec_item, {}),
    t { "" },
    i(0),
  }),

  s("ito", {
    t { "\t\\item<" },
    i(1, ""),
    t { "-> " },
    i(2),
    d(3, rec_itemly, {}),
    t { "" },
    i(0),
  }),

  s("bf", {
    t { "\\textbf{" },
    f(function(_, snip)
      -- TM_SELECTED_TEXT is a table to account for multiline-selections.
      -- In this case only the first line is inserted.
      return snip.env.TM_SELECTED_TEXT or {}
    end, {}),
    t { "} " },
    i(0),
  }),

  s("it", {
    t { "\\textit{" },
    f(function(_, snip)
      -- TM_SELECTED_TEXT is a table to account for multiline-selections.
      -- In this case only the first line is inserted.
      return snip.env.TM_SELECTED_TEXT or {}
    end, {}),
    t { "} " },
    i(0),
  }),

  s("bb", {
    t { "\\boldblue{" },
    f(function(_, snip)
      -- TM_SELECTED_TEXT is a table to account for multiline-selections.
      -- In this case only the first line is inserted.
      return snip.env.TM_SELECTED_TEXT or {}
    end, {}),
    t { "} " },
    i(0),
  }),

  s("br", {
    t { "\\boldred{" },
    f(function(_, snip)
      -- TM_SELECTED_TEXT is a table to account for multiline-selections.
      -- In this case only the first line is inserted.
      return snip.env.TM_SELECTED_TEXT or {}
    end, {}),
    t { "} " },
    i(0),
  }),

  s("bw", {
    t { "\\boldwhite{" },
    f(function(_, snip)
      -- TM_SELECTED_TEXT is a table to account for multiline-selections.
      -- In this case only the first line is inserted.
      return snip.env.TM_SELECTED_TEXT or {}
    end, {}),
    t { "} " },
    i(0),
  }),
}) -- end all
