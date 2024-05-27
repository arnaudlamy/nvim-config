map <tab> :bn<CR>
map <S-tab> :bp<CR>
map dc :bd<CR>
map ma :BlackMacchiato<CR>
map zq :set foldlevel=0<CR>
map za :set foldlevel=10<CR>
" let @p="wbveyOprint(p"
map <leader>c gc
map <silent> <C-p> <leader>ff
map <silent> <C-S-p> <leader>fg

" for mappings defined in lua
lua require('custom-map')
