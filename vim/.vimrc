syntax on
execute pathogen#infect()
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
set foldmethod=marker
nnoremap <space> za
vnoremap <space> za

call vundle#begin()

" ====================Plugins==================== {{{1
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-syntastic/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
"}}}1

" set airline be shown always, not only when splits are created
set laststatus=2

" replace tabs by spaces
set tabstop=4
set shiftwidth=4
set expandtab

call vundle#end()
filetype plugin indent on
