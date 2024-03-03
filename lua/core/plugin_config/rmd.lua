local g = vim.g

-- Nvim-R

g.R_auto_start = 2
g.R_routnotab = 1
-- vim.g.R_external_term = 1
g.R_assign = 0 -- disable convertion from "_" into "<-"
g.R_args = { "--no-save", "--quiet" } -- args when starting R
g.R_df_viewer = "View(%s)" -- View a data.frame or matrix

-- vim-markdown
g.vim_markdown_frontmatter = 1
g.tex_conceal = ""
g.vim_markdown_math = 1
-- g.vim_markdown_auto_insert_bullets = 0
-- g.vim_markdown_new_list_item_indent = 0
g.vim_markdown_follow_anchor = 1 -- Allow to follow link of header within file [first header](#first-header) with ge

vim.cmd [[
function! Compilemd()
        let extension = expand('%:e')
        if extension == "md"
                execute "! pandoc -V geometry:a4paper -V 'mainfont:Arial' -V linkcolor:blue -V fontsize=12pt --pdf-engine=xelatex % --template=eisvogel -s -o pdfs/%:t:r.pdf"
        endif
endfunction
]]
-- eisvogel : https://github.com/Wandmalfarbe/pandoc-latex-template
