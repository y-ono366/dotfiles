let g:lsp_diagnostics_enabled = 1

" debug
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/.cache/vim-lsp.log')
" let g:asyncomplete_log_file = expand('~/.cache/asyncomplete.log')
let g:lsp_log_file = ''
let g:lsp_log_verbose = 0

if executable('gopls')
  augroup LspGo
    au!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'gopls',
          \ 'cmd': {server_info->['gopls']},
          \ 'whitelist': ['go'],
          \ })
    autocmd FileType go setlocal omnifunc=lsp#complete
  augroup END
endif


if executable('vls')
  augroup LspVls
    au!
    au User lsp_setup call lsp#register_server({
          \ 'name': 'vue-language-server',
          \ 'cmd': {server_info->['vls']},
          \ 'whitelist': ['vue'],
          \ 'initialization_options': {
          \     'config': {
          \       'html': {},
          \        'vetur': {
          \          'validation': {},
          \          'completion': {
          \            'scaffoldSnippetSources': {
          \              'type': 'object',
          \              'default': {
          \                'workspace': 'home',
          \                'user': 'yusuke ohno',
          \                'vetur': 'yes'
          \              },
          \            }
          \          }
          \        }
          \     },
          \     'scaffoldSnippetSources':{}
          \   },
          \ })


    " omnifunc
    au FileType vue setlocal omnifunc=lsp#complete
  augroup end
endif

" TS LSP は .ts を開くたびに tsserver(~500MB)を起動してもっさりするので
" 既定では自動起動しない。型補完が欲しいセッションだけ :TsLsp で手動ON。
if executable('typescript-language-server')
    function! s:SetupTsLsp() abort
        call lsp#register_server({
                    \ 'name': 'typescript-language-server',
                    \ 'cmd': {server_info->['typescript-language-server', '--stdio']},
                    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
                    \ 'allowlist': ['typescript','typescript.tsx'],
                    \ })
    endfunction
    " このセッション限定で TS LSP を起動（カレントバッファに適用）
    command! TsLsp call s:SetupTsLsp() | call lsp#activate() | echomsg 'TS LSP enabled for this session'
    augroup LspTypeScript
        au!
        autocmd FileType typescript setlocal omnifunc=lsp#complete
    augroup END
else
    :echomsg "vim-lsp for typescript unavailable"
endif

if executable('solargraph')
    " gem install solargraph
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif


nnoremap gd :tab split<cr>:LspDefinition<cr>
nnoremap gD :<C-u>LspReferences<CR>
nnoremap gs :<C-u>LspDocumentSymbol<CR>
nnoremap gS :<C-u>LspWorkspaceSymbol<CR>
vnoremap gQ :LspDocumentRangeFormat<CR>
nnoremap K :<C-u>LspHover<CR>
