imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>
nmap W %
vmap W %
noremap <C-i> <esc>
noremap! <C-i> <esc>
noremap <C-h> :s/_\(.\)/\u\1/g
noremap <C-j> :s/\<\@!\([A-Z]\)/\_\l\1/g
noremap <C-u> :s/\(\w\+\)/'\1'/g
nnoremap <Leader>w :w<CR>
nnoremap <Leader>R h"bplvwhhxxb
nnoremap <Leader>r ve"0pb
" nnoremap <Leader>r ciw<C-r>0<ESC>b
nnoremap <Leader>y ve"0y
nnoremap <Leader>qq :qa!<CR>
nmap <C-o><C-o> <ESC>i<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR><ESC>
" nnoremap <Leader>n :Ve<CR>
