let setFiletypes = {
    \ 'go'  : {'noexpandtab':'','tabstop':'4','shiftwidth':'4'},
    \ 'php'  : {'tabstop':'4','shiftwidth':'4','autoindent':''},
    \ 'js'  : {'tabstop':'2','shiftwidth':'2'},
    \ 'ts'  : {'tabstop':'2','shiftwidth':'2'},
    \ 'vue' : {'tabstop':'2','shiftwidth':'2'},
    \ 'vim' : {'tabstop':'2','shiftwidth':'2'},
    \ 'pug' : {'tabstop':'2','shiftwidth':'2'},
    \ 'scss' : {'tabstop':'2','shiftwidth':'2'},
    \ 'tmpl': {'filetype':'html'},
    \ 'tsx' : {'filetype':'typescript.tsx'},
    \ 'vert' : {'filetype':'glsl'},
    \ 'frag' : {'filetype':'glsl'},
    \ 'lvim': {'filetype':'vim'}}


function! FileTypeIndent(setFiletypes) abort
    augroup fileTypeIndent
         autocmd!
         for [ extension,props ] in items(a:setFiletypes)
             for [l_key,val]in items(props)
                execute "autocmd BufNewFile,BufRead *." . extension . " setlocal ".l_key val == ''?'':'='.val
             endfor
         endfor
    augroup END
endfunction

call FileTypeIndent(setFiletypes)
