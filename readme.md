# Config Installation

1. Path Neovim `:echo stdpath('config')` in Neovim. It is usually`$env:LOCALAPPDATA`.
2. Clone your nvim config to `git clone git@github.com:777uliahshafar/nvim.git "$env:LOCALAPPDATA\nvim"`
3. cd to nvim configration folder `nc`.

# Nvim Installation

1. Package manager is using lazy nvim plugin manager.
2. Ripgrep `scoop install ripgrep`, required for nvim-tree & Obsidian.
3. fd `scoop install fd` required for nvim-tree.
4. zig `scoop install zig` required for nvim-treesitter. `:TSInstallInfo` available language, `:TSUpdate` update parsers unconditionally.
5. python `scoop install python` and python client to nvim `pip3 install pynvim` required for thesaurus_query.
6. obsidian, create/move folder for obsidian manually if it doesn't provide automatically `~/obs`. You've stored it in GDrive.
7. place .latexmkrc in home directory `C:\Users\<username>\`. This contain command to delete all generated aux files (as latexmk -C) and other command you wish for.
8. latexindent.pl configuration : place indentconfig.yaml in home directory `C:\Users\<username>\` which contains the path to your `defaultSettings.yaml` in nvim directory. You may need install its package from Miktex.

Windows users may find that they have to end .yaml files with a blank line.

_indentconfig.yaml_ content

```
paths:
  - C:\Users\<username>\AppData\Local\nvim\defaultSettings.yaml

```

14. Nvim-R require installation of R for Windows and (Rtools)[https://cran.r-project.org/bin/windows/Rtools/]

- Install R packaged required by `install.packages("pkgs")`.

15. Luasnip use snipmate sourcecode for snippet.

16. Copy lexicon folder from GDrive (textediting folder) to homedirectory. This include file for nvim plugin thesaurus and cmp-dict.

PS. Check your nvim config `:checkhealth`

# Faq vimtex

1. How to deal with Swap Warning

- Recover the swap file(r)
- If the content looks right, Save(:w) and Reopen(:e).
- If the content older, Reopen without Save(:r!)
- Delete swap file (d) or manually from zsh.

2. Lag in a long line and large file

- Refresh fold with `<F6>`, from fastfold vim plugin.

3. Word count (through `texcount` from MikteX).
