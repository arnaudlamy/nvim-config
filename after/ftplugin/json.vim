" let the initial folding state be that all folds are closed.
set foldlevel=1000

" Use nvim-treesitter for folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
