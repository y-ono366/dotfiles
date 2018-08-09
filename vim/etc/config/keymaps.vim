imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>
nmap j <Plug>(accelerated_jk_gj_position)
nmap k <Plug>(accelerated_jk_gk_position)
nmap W %
noremap <C-i> <esc>
noremap! <C-i> <esc>
noremap <C-h> :s/_\(.\)/\u\1/g
noremap <C-n> :s/\<\@!\([A-Z]\)/\_\l\1/g
noremap <C-u> :s/\(\w\+\)/'\1'/g
nnoremap <Leader>w :w<CR>
nnoremap <Leader>rr :call RReplace()<CR>
nnoremap <Leader>r :call Replace()<CR>
nnoremap <Leader>y :call Cpword()<CR>
nnoremap <Leader>t :NERDTree<CR>
nnoremap <Leader>qq :qa!<CR>
