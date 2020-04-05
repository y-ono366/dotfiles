let setFiletypes = {
    \ 'go'  : {'noexpandtab':'','tabstop':'4','shiftwidth':'4'},
    \ 'js'  : {'tabstop':'2','shiftwidth':'2'},
    \ 'vue' : {'tabstop':'2','shiftwidth':'2'},
    \ 'vim' : {'tabstop':'2','shiftwidth':'2'},
    \ 'tmpl': {'filetype':'html'},
    \ 'tsx' : {'filetype':'typescript.tsx'},
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
