let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif

  if has("win64")
    execute 'set runtimepath^=' . s:dein_repo_dir
  else
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
  endif

endif

autocmd vimenter * syntax on
  call dein#begin(s:dein_dir)
  let g:rc_dir    = expand('~/dotfiles/vim/etc/plugins/')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
if dein#check_install()
  call dein#install()
endif

for file in split(glob('~/dotfiles/vim/**/*.vim'), '\n')
    exe 'source' file
endfor
