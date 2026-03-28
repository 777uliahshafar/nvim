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
      t "", -- berhenti
      sn(nil, {
        t { "", "\\item " },
        i(1),
        d(2, rec_item, {}),
      }),
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
    "multicol",
    fmt("\\multicolumn{{{}}}{{{}}}{{{}}}", {
      i(1, "numcol"),
      i(2, "c"),
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ), --end of snip
  s(
    "multirow",
    fmt("\\multirow{{{}}}{{{}}}{{{}}}", {
      i(1, "numrow"),
      i(2, "*"),
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ), --end of snip
  s(
    "inc",
    fmt("\\includepdf[pages={{{}}},pagecommand={{\\thispagestyle{{{}}}\\fakesection{{{}}}}}]{{{}}}", {
      i(1, "pagenum"),
      c(2, { t "plain", t "empty," }),
      i(3, "titlesec"),
      i(4, "file.pdf"),
    })
  ), --end of snip
  s("secp", {
    t { "\\section{" },
    f(function(_, snip)
      return snip.env.TM_SELECTED_TEXT or { "Section Title" }
    end, {}),
    t { "}%", "" },
    t { "\\label{sec:" },
    f(function(_, snip)
      local text = snip.env.TM_SELECTED_TEXT and snip.env.TM_SELECTED_TEXT[1] or "section_title"
      text = string.lower(text)
      text = text:gsub("%s+", "_")
      return text
    end, {}),
    t { "}", "" },
    i(0),
  }), --end of snip
  s("subp", {
    t { "\\subsection{" },
    f(function(_, snip)
      return snip.env.TM_SELECTED_TEXT or { "Subsection Title" }
    end, {}),
    t { "}%", "" },
    t { "\\label{sub:" },
    f(function(_, snip)
      local text = snip.env.TM_SELECTED_TEXT and snip.env.TM_SELECTED_TEXT[1] or "subsection_title"
      text = string.lower(text)
      text = text:gsub("%s+", "_")
      return text
    end, {}),
    t { "}", "" },
    i(0),
  }), --end of snip
  s("ssubp", {
    t { "\\subsubsection{" },
    f(function(_, snip)
      return snip.env.TM_SELECTED_TEXT or { "Subsubsection Title" }
    end, {}),
    t { "}%", "" },
    t { "\\label{ssub:" },
    f(function(_, snip)
      local text = snip.env.TM_SELECTED_TEXT and snip.env.TM_SELECTED_TEXT[1] or "subsubsection_title"
      text = string.lower(text)
      text = text:gsub("%s+", "_")
      return text
    end, {}),
    t { "}", "" },
    i(0),
  }), --end of snip
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
    "txtl",
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
    "reffig",
    fmt("{}~\\ref{{fig:{}}}", {
      c(1, {
        t "gambar",
        t "figure",
      }),
      i(2), -- Placeholder for the figure reference
    })
  ), --end of snip
  s(
    "reftab",
    fmt("{}~\\ref{{tab:{}}}", {
      c(1, {
        t "tabel",
        t "table",
      }),
      i(2), -- Placeholder for the figure reference
    })
  ), --end of snip
  s(
    "txtr",
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
    "txtlp",
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
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ), --end of snip

  s(
    "txtrp",
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
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ), --end of snip

  s(
    "txtu",
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
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ), --end of snip

  s(
    "txtb",
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
    "txtbp",
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
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
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
    fmt("\\noc{{1-}}{{{}}}", {
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ), -- end of snip
  s(
    "nip",
    fmt("\\nit{{1-}}{{{}}}", {
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ), -- end of snip
  s(
    "fm",
    fmt(
      [[
    \begin{{frame}}[{}{}{}]{}{}
    ]],
      {
        c(1, {
          t "mytitle=standard,",
          t "mytitle=center,",
          t "mytitle=imageplus,",
        }),
        c(2, {
          t "t,",
          t "c,",
        }),
        c(3, {
          t "mybg=adddarkbg,dark",
          t "mybg=addlightbg,light",
          t "mycolor=digiPH_white,light",
          t "mycolor=digiPH_uniblue,light",
          t "mycolor=digiPH_gray,light",
          t "mycolor=digiPH_leaf,dark",
          t "mycolor=digiPH_ocean,dark",
          t "mycolor=digiPH_ubcblue,dark",
          t "mycolor=digiPH_red,dark",
          t "mycolor=digiPH_gray,light",
          t "mycolor=digiPH_cream,light",
          t "mycolor=digiPH_creamy,dark",
          t "mycolor=digiPH_purple,dark",
        }),
        i(4, "konten"),
        t { "\\end{frame}" },
      }
    )
  ), --end of snip

  s(
    "fmp",
    fmt(
      [[
    \begin{{frame}}[{}{}{}]{}{}
    ]],
      {
        c(1, {
          t "mytitle=standard,",
          t "mytitle=center,",
          t "mytitle=imageplus,",
        }),
        c(2, {
          t "t,",
          t "c,",
        }),
        c(3, {
          t "mybg=adddarkbg,dark",
          t "mybg=addlightbg,light",
          t "mycolor=digiPH_white,light",
          t "mycolor=digiPH_uniblue,light",
          t "mycolor=digiPH_gray,light",
          t "mycolor=digiPH_leaf,dark",
          t "mycolor=digiPH_ocean,dark",
          t "mycolor=digiPH_ubcblue,dark",
          t "mycolor=digiPH_red,dark",
          t "mycolor=digiPH_gray,light",
          t "mycolor=digiPH_cream,light",
          t "mycolor=digiPH_creamy,dark",
          t "mycolor=digiPH_purple,dark",
        }),
        f(function(_, snip)
          -- TM_SELECTED_TEXT is a table to account for multiline-selections.
          -- In this case only the first line is inserted.
          return snip.env.TM_SELECTED_TEXT or {}
        end, {}),
        t { "\\end{frame}" },
      }
    )
  ), --end of snip
  s("ftp", {
    t { "\\frametitle{" },
    f(function(_, snip)
      -- TM_SELECTED_TEXT is a table to account for multiline-selections.
      -- In this case only the first line is inserted.
      return snip.env.TM_SELECTED_TEXT or {}
    end, {}),
    t { "} " },
    i(0),
  }), --end of snip
  s("fsp", {
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
    fmt("\\includegraphics[{}{}]{{{}{}}}", {
      c(1, { t "", t "draft," }),
      c(2, { t "width=40mm", t "width=.86\\textwidth", t "height=.95\\textheight" }),
      t { "../figures/" },
      i(3, "placeholder.ext"),
    })
  ), --end of snip

  s(
    "subfile",
    fmt("\\subfile{{subfiles/{}.tex}}", {
      i(1, "filename"),
    })
  ), --end of snip

  s(
    "izp",
    fmt("\\begin{{itemize}}{}\\end{{itemize}}", {
      f(function(_, snip)
        -- TM_SELECTED_TEXT is a table to account for multiline-selections.
        -- In this case only the first line is inserted.
        return snip.env.TM_SELECTED_TEXT or {}
      end, {}),
    })
  ), --end of snip
  s(
    "itmp",
    f(function(_, snip)
      local selected = snip.env.TM_SELECTED_TEXT

      -- kalau tidak ada visual selection
      if type(selected) ~= "table" then
        return {
          "\\begin{itemize}",
          "\\item ",
          "\\end{itemize}",
        }
      end

      local result = { "\\begin{itemize}" }

      for _, line in ipairs(selected) do
        table.insert(result, "\\item " .. line)
      end

      table.insert(result, "\\end{itemize}")

      return result
    end, {})
  ), --end of snip
  s("itm", {
    t "\\item ",
    i(1),
    d(2, rec_item, {}),
  }), --end of snip

  s("bf", {
    t { "\\textbf{" },
    f(function(_, snip)
      -- TM_SELECTED_TEXT is a table to account for multiline-selections.
      -- In this case only the first line is inserted.
      return snip.env.TM_SELECTED_TEXT or {}
    end, {}),
    t { "}" },
    i(0),
  }),

  s("it", {
    t { "\\textit{" },
    f(function(_, snip)
      -- TM_SELECTED_TEXT is a table to account for multiline-selections.
      -- In this case only the first line is inserted.
      return snip.env.TM_SELECTED_TEXT or {}
    end, {}),
    t { "}" },
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
