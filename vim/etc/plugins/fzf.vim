" nmap <C-p> :Files<CR>

nnoremap <C-p> :FZFFileList<CR>

if has("win64")
    command! FZFFileList call fzf#run(fzf#wrap({
                \ 'source': 'where /r . *',
                \ 'down': '50%'}))
else
    command! FZFFileList call fzf#run(fzf#wrap({
                \ 'source': 'find . -type d -name .git -prune -o ! -name .DS_Store',
                \ 'down': '50%'}))
endif

let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

nnoremap <Leader>h :History:<CR>

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>,fzf#vim#with_preview('right:50%'),<bang>0)

command! -bang -nargs=+ -complete=dir SnippetsDefault
        \ call fzf#vim#ag_raw(<q-args> . ' ~/.cache/dein/.cache/.vimrc/.dein/snippets/',
        \ fzf#vim#with_preview(), <bang>0)

function! s:fzf_ag_raw(cmd)
  call fzf#vim#ag_raw('--noheading '. a:cmd)
endfunction
