let g:lsp_diagnostics_enabled = 0

" debug
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')
let g:asyncomplete_log_file = expand('~/asyncomplete.log')

if executable('go-langserver')
    augroup LspGols
        au!
        au User lsp_setup call lsp#register_server({
               \ 'name': 'go-langserver',
               \ 'cmd': {server_info->['go-langserver']},
               \ 'whitelist': ['go'],
               \ })

        au FileType go setlocal omnifunc=lsp#complete
        " map
        au FileType go nnoremap <buffer><silent> gd :<C-u>LspDefinition<CR>
        au FileType go nnoremap <buffer><silent> gD :<C-u>LspReferences<CR>
        au FileType go nnoremap <buffer><silent> gs :<C-u>LspDocumentSymbol<CR>
        au FileType go nnoremap <buffer><silent> gS :<C-u>LspWorkspaceSymbol<CR>
        au FileType go vnoremap <buffer><silent> gQ :LspDocumentRangeFormat<CR>
        au FileType go nnoremap <buffer><silent> K :<C-u>LspHover<CR>
    augroup end
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
        " map
        au FileType vue nnoremap <buffer><silent> gd :<C-u>LspDefinition<CR>
        au FileType vue nnoremap <buffer><silent> gD :<C-u>LspReferences<CR>
        au FileType vue nnoremap <buffer><silent> gs :<C-u>LspDocumentSymbol<CR>
        au FileType vue nnoremap <buffer><silent> gS :<C-u>LspWorkspaceSymbol<CR>
        au FileType vue vnoremap <buffer><silent> gQ :LspDocumentRangeFormat<CR>
        au FileType vue nnoremap <buffer><silent> K :<C-u>LspHover<CR>
    augroup end
endif
