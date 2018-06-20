" system系
" 文字コードUTF-8
set fenc=utf-8
" 編集中のファイル名表示
set title
" 編集中のファイルが変更されたら自動で読み込み直す
set autoread
" スワップファイルを作らない
set noswapfile
" コマンドライン補完候補表示
set wildmenu


" 見た目系
" 行番号の表示
set nu
" 右下の行・列番号を表示
set ruler
" 閉じカッコ入力時対応括弧の強調
set showmatch
" 行頭、行末でのカーソル移動
set whichwrap=h,l

" Tab系
" 自動インデント有効
set autoindent
" タブ幅
set tabstop=2
" 自動挿入インデント
set shiftwidth=2
" タブ入力時幅
set softtabstop=2

" 検索系
" 文字列検索大文字小文字区別なし
set ignorecase
" 文字列検索ハイライト
set hlsearch
" 検索文字に大文字が含まれるとき大文字小文字を区別
set smartcase
" showmatchの表示秒数 0.1秒単位
set matchtime=4

" ファイルタイプ別のプラグイン/インデントを有効にする
filetype plugin indent on

syntax enable

" ターミナルでマウス使用可能
if has("mouse")
	set mouse=a
	set guioptions+=a
	set ttymouse=xterm2
endif

" statusline表示
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

" ---------- vim-plug start ----------
if has('vim_starting')
  " 初回起動時のみruntimepathにvim-plugのパス指定
  set rtp+=~/.vim/plugged/vim-plug
	" Powerlineも
	set rtp+=~/Library/Python/3.6/lib/python/site-packages/powerline/bindings/vim/

	if !isdirectory(expand('~/.vim/plugged/vim-plug'))
		echo 'install vim-plug...'
		call system('mkdir -p ~/.vim/plugged/vim-plug')
		call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
	endif
endif

call plug#begin('~/.vim/plugged')

" git
Plug 'tpope/vim-fugitive'

" color schema
Plug 'flazz/vim-colorschemes'

" tmux powerline
" Plug 'edkolev/tmuxline.vim'

" vim-lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" TypeScript
Plug 'leafgarland/typescript-vim'
Plug 'ryanolsonx/vim-lsp-typescript'
Plug 'runoshun/tscompletejob'
Plug 'prabirshrestha/asyncomplete-tscompletejob.vim'

" ---------- vim-plug end ----------
call plug#end()

" ---------- vim-lsp setting ----------
" - TypeScript
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript'],
        \ })
endif
call asyncomplete#register_source(asyncomplete#sources#tscompletejob#get_source_options({
    \ 'name': 'tscompletejob',
    \ 'whitelist': ['typescript'],
    \ 'completor': function('asyncomplete#sources#tscompletejob#completor'),
    \ }))

" ---------- tmuxline conf ----------
let g:tmuxline_preset = {
  \'a'    : '#S',
  \'c'    : ['#(whoami)', '#(uptime | cud -d " " -f 1,2,3)'],
  \'win'  : ['#I', '#W'],
  \'cwin' : ['#I', '#W', '#F'],
  \'x'    : '#(date)',
  \'y'    : ['%R', '%a', '%Y'],
  \'z'    : '#H'}


" -------------commands-------
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
	if 0 == a:0
		let l:arg = "."
	else
		let l:arg = a:1
	endif
	execute "%! jq 95fe1a73-e2e2-4737-bea1-a44257c50fc8quot;" . l:arg . "95fe1a73-e2e2-4737-bea1-a44257c50fc8quot;"
endfunction

" ------HexEditSetting------
augroup BinaryXXD
	autocmd!
	autocmd BufReadPre		*.bin let &binary =1
	autocmd BufReadPost		* if &binary | silent %!xxd -g 1
	autocmd BufReadPost		*	set ft=xxd | endif
	autocmd BufWritePre		* if &binary | %!xxd -r | endif
	autocmd BufWritePost	* if &binary | silent %!xxd -g 1
	autocmd BufWritePost	* set nomod	| endif
augroup END
