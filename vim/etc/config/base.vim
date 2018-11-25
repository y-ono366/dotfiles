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
" 空白文字の可視化
set list
" 不可視文字を可視化(タブが「▸-」と表示される)
set listchars=tab:>-,trail:_
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
" ステータスライン
set statusline=%F%m%r%h%w%=[ENC=%{&fileencoding}][FORMAT=%{&ff}][LOW=%l/%L]

filetype on
" TABキーを押した際にタブ文字の代わりにスペースを入れる
set expandtab
set tabstop=4
" 自動インデント
set shiftwidth=4
" autoindent
set autoindent
set noautoindent
set clipboard+=unnamedplus,unnamed,autoselect
" undoファイル無効化
set noundofile
" syntax on
syntax on
" 表示折り返す
set wrap
" ビープ音OFF
set vb t_vb=
" 起動時のメッセージを消す
set shortmess& shortmess+=I
" 起動時IMEをOFFにする
set iminsert=0 imsearch=0
" バックスペースでなんでも消せるように
set backspace=indent,eol,start
"  改行時にコメントしない
set formatoptions-=r
set formatoptions-=o
" 日本語ヘルプを優先
set helplang=ja,en
" h と l で行を跨げるようにする
set whichwrap +=h
set whichwrap +=l
" history size
set history=100
set relativenumber

let mapleader = "\<Space>"
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.go  setlocal noexpandtab tabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.js  setlocal tabstop=2 shiftwidth=2
augroup END
