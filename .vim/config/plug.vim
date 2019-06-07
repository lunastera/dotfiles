if has('vim_starting')
  " 初回起動時のみruntimepathにvim-plugのパス指定
  set rtp+=~/.vim/plugged/vim-plug
	" Powerlineも
	set rtp+=~/Library/Python/3.7/lib/python/site-packages/powerline/bindings/vim/

	if !isdirectory(expand('~/.vim/plugged/vim-plug'))
		echo 'install vim-plug...'
		call system('mkdir -p ~/.vim/plugged/vim-plug')
		call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
	endif
endif

call plug#begin('~/.vim/plugged')

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

" LanguageServerProtocolPlugins {{{
"" deoplete 
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
"" LanguageClient-neovim
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
"" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'
" }}}

" Ruby Plugins
Plug 'tpope/vim-endwise'

call plug#end()
