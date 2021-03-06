" Required by Vundle
filetype off

" Enable Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Vundle plugins
if !has("win32") && !has("win32unix")
  Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'majutsushi/tagbar'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/nerdtree'

" Syntax Highlighting
Plugin 'ekalinin/Dockerfile.vim'

" Fix gvim color schemes for terminal vim.
Plugin 'godlygeek/csapprox'
" Plugin 'KevinGoodsell/vim-csexact'

" Color schemes for Vundle
Plugin 'CruizeMissile/Revolution.vim'
Plugin 'gosukiwi/vim-atom-dark'
Plugin 'dterei/VimCobaltColourScheme'

" Turn on smart pane switching thingy for tmux.
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()
" Put the filetype back the way I want it.
filetype plugin indent on
