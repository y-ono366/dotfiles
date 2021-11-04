let g:lsp_diagnostics_enabled = 0

" debug
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/.cache/vim-lsp.log')
" let g:asyncomplete_log_file = expand('~/.cache/asyncomplete.log')
let g:lsp_log_file = ''
let g:lsp_log_verbose = 1

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

if executable('typescript-language-server')
    augroup LspTypeScript
        au!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'typescript-language-server',
                    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
                    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
                    \ 'whitelist': ['typescript','typescript.tsx'],
                    \ })
        autocmd FileType typescript setlocal omnifunc=lsp#complete
    augroup END :echomsg "vim-lsp with `typescript-language-server` enabled"
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
