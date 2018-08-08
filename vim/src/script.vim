" bにyankしたテキストと入れ替える
function! Replace()
    execute 'normal h"bplvwhhxx'
endfunction


function! Rline(start,end)
  call setline(1,range(a:start,a:end))
endfunction

function! Cpword()
    execute 'normal vey'
endfunction
