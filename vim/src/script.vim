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
