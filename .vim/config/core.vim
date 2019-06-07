" System {{{
" 文字コードUTF-8
set encoding=utf-8
" 編集中のファイル名表示
set title
" 編集中のファイルが変更されたら自動で読み込み直す
set autoread
" スワップファイルを作らない
set noswapfile
" コマンドライン補完候補表示
set wildmenu
" vimファイルでの折りたたみマーカーをサポート
set nofoldenable
set foldmethod=syntax
au FileType vim setlocal foldmethod=marker
" Insertのみmanual
autocmd InsertEnter * if !exists('w:last_fdm')
            \| let w:last_fdm=&foldmethod
            \| setlocal foldmethod=manual
            \| endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm')
            \| let &l:foldmethod=w:last_fdm
            \| unlet w:last_fdm
						\| endif
" }}}

"" Visual {{{
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none
" バッファの区切りの~を非表示
highlight link EndOfBuffer Ignore
" vsplitをいい感じにする
set fillchars+=vert:│
hi VertSplit cterm=NONE ctermbg=NONE
" 行番号の表示
set nu
" 右下の行・列番号を表示
set ruler
" 閉じカッコ入力時対応括弧の強調
set showmatch
" 行頭、行末でのカーソル移動
set whichwrap=h,l
" コマンドを表示
set showcmd
"" }}}

" Tab {{{
" 自動インデント有効
set autoindent
set expandtab
" Tab挿入時の見た目幅
set tabstop=2
" 自動挿入インデント量
set shiftwidth=2
set softtabstop=2
" }}}

" Search {{{
" 文字列検索大文字小文字区別なし
set ignorecase
" 文字列検索ハイライト
set hlsearch
" 検索文字に大文字が含まれるとき大文字小文字を区別
set smartcase
" showmatchの表示秒数 0.1秒単位
set matchtime=4
" }}}

filetype plugin indent on
syntax enable

" MouseSetting
if has("mouse")
	set mouse=a
	set guioptions+=a
	set ttymouse=xterm2
endif

" StatusLine
set laststatus=2
set showtabline=2
set noshowmode
set showcmd

" Powerline
" let g:Powerline_symbols = 'fancy'
" 文字化けするならこっち
" let g:Powerline_symbols = 'compatible'
set t_Co=256
set timeoutlen=1000 ttimeoutlen=0
