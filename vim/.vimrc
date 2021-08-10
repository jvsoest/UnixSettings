syntax on
execute pathogen#infect()
set nocompatible
colorscheme default
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
set foldmethod=marker
set wrap linebreak nolist breakindent
nnoremap <space> za
vnoremap <space> za

call vundle#begin()

" ====================Plugins==================== {{{1
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-syntastic/syntastic'
Plugin 'preservim/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'

" R plugins
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-rmarkdown'
Plugin 'Vim-R-plugin'

Plugin 'seebi/semweb.vim'
"}}}1

" set airline be shown always, not only when splits are created
set laststatus=2

" replace tabs by spaces
set tabstop=4
set shiftwidth=4
set expandtab

call vundle#end()
filetype plugin indent on
