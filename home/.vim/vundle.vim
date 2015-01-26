" Required by Vundle
filetype off

" Enable Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Vundle plugins
Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/nerdtree'

" Color schemes for Vundle
Plugin 'CruizeMissile/Revolution.vim'
Plugin 'gosukiwi/vim-atom-dark'

call vundle#end()
" Put the filetype back the way I want it.
filetype plugin indent on
