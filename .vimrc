let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

autocmd vimenter * syntax on
  call dein#begin(s:dein_dir)
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  call dein#load_toml(s:toml,      {'lazy': 0})
" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif


:so $HOME/dotfiles/vim/etc/config/base.vim
:so $HOME/dotfiles/vim/etc/config/alias.vim
:so $HOME/dotfiles/vim/etc/config/keymaps.vim
:so $HOME/dotfiles/vim/etc/modules/ag.vim
:so $HOME/dotfiles/vim/etc/modules/nerdtree.vim
:so $HOME/dotfiles/vim/etc/modules/quickrun.vim
:so $HOME/dotfiles/vim/etc/modules/unite.vim
:so $HOME/dotfiles/vim/etc/modules/table-mode.vim
:so $HOME/dotfiles/vim/src/script.vim
