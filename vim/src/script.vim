command! -nargs=? Nl call Nl(<f-args>)
function! Nl(...)
    execute "%s/".a:1."/\r".a:1."/gI"
endfunction

function! ProfileCursorMove() abort
  let profile_file = expand('~/log/vim-profile.log')
  if filereadable(profile_file)
    call delete(profile_file)
  endif

  normal! gg
  normal! zR

  execute 'profile start ' . profile_file
  profile func *
  profile file *

  augroup ProfileCursorMove
    autocmd!
    autocmd CursorHold <buffer> profile pause | q
  augroup END

  for i in range(100)
    call feedkeys('j')
  endfor
endfunction

command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction

" curl でhtml叩いて、整形して表示する
command! -nargs=? Curl call s:Curl(<f-args>)
function! s:Curl(...)
    if 0 == a:0
        return
    else
        let l:arg = a:1
    endif
    execute "%! curl \"" . l:arg . "\""
" :%s/></>\r</g | filetype indent on | setf html | normal gg=G
endfunction
