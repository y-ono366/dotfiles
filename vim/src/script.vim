function! Rline(start,end)
  call setline(1,range(a:start,a:end))
endfunction
" bにyankしたテキストと入れ替える
function! Replace()
    execute 'normal h"bplvwhhx'
endfunction

