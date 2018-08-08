function! Rline(start,end)
  call setline(1,range(a:start,a:end))
endfunction

function! Replace()
    execute 'normal h"bplvwhhx'
endfunction

