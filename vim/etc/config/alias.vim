:command Tr NERDTree
:command Ss split
:command Sv vsplit
:command Dd %s/ *$//
:command Dl v/./d
:command Do DiffOrig
:command Qr QuickRun
:command Nw rightbelow vne
:command Nm :%s/^/\=line(".")
:command Nt tabnew
:command Suw :w !sudo tee > /dev/null %<CR> :e!<CR>
