" Ctrl+d フルパス検索モードとファイル名のみの検索モードを切り替え
" Ctrl+r 正規表現検索モードと通常の検索モードを切り替え
" Ctrl+f,Ctrl+b	検索対象（バッファとか）を切り替え
if executable('ag')
  let g:ctrlp_use_caching=0
  let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
endif
let g:ctrlp_lazy_update = 1
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0

let g:ctrlp_max_height = 40
