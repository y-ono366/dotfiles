" 保存時のみ実行する
let g:ale_lint_on_text_changed = 0
" 表示に関する設定
let g:ale_sign_error = '?'
let g:ale_sign_warning = '?'
let g:airline#extensions#ale#open_lnum_symbol = '('
let g:airline#extensions#ale#close_lnum_symbol = ')'
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
highlight link ALEErrorSign Tag
highlight link ALEWarningSign StorageClass
" function! LinterStatus() abort
"     let l:counts = ale#statusline#Count(bufnr(''))
"
"     let l:all_errors = l:counts.error + l:counts.style_error
"     let l:all_non_errors = l:counts.total - l:all_errors
"
"     return l:counts.total == 0 ? 'OK' : printf(
"     \   '%dW %dE',
"     \   all_non_errors,
"     \   all_errors
"     \)
" endfunction
" set statusline+=%{LinterStatus()}

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'javascript': ['prettier','eslint'],
\   'json'      : ['prettier'],
\}

let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = 1
let g:ale_lint_on_enter = 0
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0
