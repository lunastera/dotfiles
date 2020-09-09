if has('vim_starting')
  " 初回起動時のみruntimepathにvim-plugのパス指定
  set rtp+=~/.vim/plugged/vim-plug

	if !isdirectory(expand('~/.vim/plugged/vim-plug'))
		echo 'install vim-plug...'
		call system('mkdir -p ~/.vim/plugged/vim-plug')
		call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
	endif
endif

call plug#begin('~/.vim/plugged')

" lightline
Plug 'itchyny/lightline.vim'

" indent-guide
Plug 'nathanaelkane/vim-indent-guides'

" [gcc][{Visual}gc]comment out
Plug 'tpope/vim-commentary'

" git
Plug 'tpope/vim-fugitive'

" color scheme
Plug 'flazz/vim-colorschemes'

" NerdTree
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Ruby Plugins
Plug 'tpope/vim-endwise'

call plug#end()
