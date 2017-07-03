" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
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

" Unite
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" NERDTreeの設定
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Jsファイルの場合設定変更
" autocmd filetype coffee,javascript setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

" vim-table-mode
function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

" QuickRun
let g:quickrun_config = {
 \ "javascript": {
 \   "command": "node",
 \   "tempfile": "{tempname()}.js"
 \   }
 \ }
let g:quickrun_config={'*': {'split': ''}}

" Alias
:command Tr NERDTree
:command Ss split
:command Sv vsplit
:command Dd %s/ *$//
:command Do DiffOrig
:command Qr QuickRun

" key maps
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>
nmap j <Plug>(accelerated_jk_gj_position)
nmap k <Plug>(accelerated_jk_gk_position)
nmap W %
noremap <C-i> <esc>
noremap! <C-i> <esc>

"---------- GUI----------
" スキーマ
colorscheme gruvbox
let g:gruvbox_underline = 1
let g:gruvbox_contrast_dark = 'medium'
set background=dark
set lines=55
set columns=180
set selection=inclusive
set laststatus=2
set t_Co=256

" --------基本設定------------
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" タイトルの表示
set title
" スクロールバー
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
" set smartindent
" 括弧入力時の対応する括弧を表示
set showmatch
" コマンドラインの補完
set wildmode=list:longest
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-,trail:_
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" 空白文字の可視化
set list

" TABキーを押した際にタブ文字の代わりにスペースを入れる
set expandtab
set tabstop=4
" 自動インデント
set shiftwidth=4

filetype off
