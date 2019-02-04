" nmap <C-p> :Files<CR>

nnoremap <C-p> :FZFFileList<CR>

if has("win64")
    command! FZFFileList call fzf#run(fzf#wrap({
                \ 'source': 'where /r . *',
                \ 'down': '40%'}))
else
    command! FZFFileList call fzf#run(fzf#wrap({
                \ 'source': 'find . -type d -name .git -prune -o ! -name .DS_Store',
                \ 'down': '40%'}))
endif

let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

nnoremap <Leader>h :History:<CR>
