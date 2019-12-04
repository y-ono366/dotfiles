let g:lsp_diagnostics_enabled = 0

" debug
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/.cache/vim-lsp.log')
let g:asyncomplete_log_file = expand('~/.cache/asyncomplete.log')

if executable('go-langserver')
  augroup LspGo
    au!
    au User lsp_setup call lsp#register_server({
          \ 'name': 'go-langserver',
          \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
          \ 'whitelist': ['go'],
          \ })
    au FileType go setlocal omnifunc=lsp#complete
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


nnoremap gd :tab split<cr>:LspDefinition<cr>
nnoremap gD :<C-u>LspReferences<CR>
nnoremap gs :<C-u>LspDocumentSymbol<CR>
nnoremap gS :<C-u>LspWorkspaceSymbol<CR>
vnoremap gQ :LspDocumentRangeFormat<CR>
nnoremap K :<C-u>LspHover<CR>
