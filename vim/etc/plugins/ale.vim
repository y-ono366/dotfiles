let g:ale_echo_msg_format = '[%linter%]%code: %%s'
highlight link ALEErrorSign Tag
highlight link ALEWarningSign StorageClass

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0

let g:ale_lint_on_text_changed = get(g:, 'ale_lint_on_text_changed', 'never')
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_echo_cursor = get(g:, 'ale_echo_cursor', 0)
let g:ale_virtualtext_cursor = get(g:, 'ale_virtualtext_cursor', 0)
"
let g:ale_fix_on_save = 1
let g:ale_floating_preview = 0
let g:ale_lsp_suggestions = 1
let g:ale_javascript_prettier_use_local_config = 1
" let g:ale_php_phpstan_use_global = 1

let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint','tsserver'],
\ 'typescript.tsx': ['eslint','tsserver'],
\ 'vue'       : ['vls','eslint'],
\ 'go'        : ['gopls'],
\ }

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'typescript.tsx': ['prettier'],
\   'vue'       : ['prettier'],
\   'go'        : ['gofmt'],
\   'json'      : ['prettier'],
\}

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

