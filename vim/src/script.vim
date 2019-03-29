" bにyankしたテキストと入れ替える
function! RReplace()
    execute 'normal h"bplvwhhxxb'
endfunction

function! Replace()
    execute 'normal vepb'
endfunction

function! Rline(start,end)
  call setline(1,range(a:start,a:end))
endfunction

function! Cpword()
    execute 'normal vey'
endfunction

command! -nargs=* Cr call Cr(<f-args>)
function! Cr(...)
    if a:0 == 1
        execute "%s/".a:1."/\r".a:1."/gI"
    elseif a:2 == 1
        execute "%s/".a:1."/".a:1."\r/gI"
    endif
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
