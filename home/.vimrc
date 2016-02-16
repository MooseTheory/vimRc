set nocompatible

source ~/.vim/vundle.vim

" Enable filetype plugins
filetype plugin on
filetype indent on

" Enable syntax highlighting
syntax enable

" Use 'smart' tabs
set smarttab
" 1 tab = 2 spaces
set shiftwidth=2
set tabstop=2

" Auto indent
set autoindent
" Smart indent
set smartindent

" Set up astyle.
autocmd BufNewFile,BufRead *.h set formatprg=astyle\ --indent=spaces=2\ --break-blocks\ --pad-oper\ --align-pointer=type\ --style=google\ --add-brackets\ --convert-tabs\ --max-code-length=80
autocmd BufNewFile,BufRead *.cpp set formatprg=astyle\ --indent=spaces=2\ --break-blocks\ --pad-oper\ --align-pointer=type\ --style=google\ --add-brackets\ --convert-tabs\ --max-code-length=80
autocmd BufNewFile,BufRead *.d set formatprg=astyle\ --indent=spaces=2\ --break-blocks\ --pad-oper\ --align-pointer=type\ --style=google\ --add-brackets\ --convert-tabs\ --max-code-length=80

" Make the 81st column stand out.
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Remap semicolon to colon.
nnoremap ; :

" Make unnecessary whitespace more obvious.
" The function is to avoid showing it when I'm using go because it has
" prefers tabs to spaces.
function! ShowWhitespace()
  if &filetype =~ 'go'
    return
  endif
  " Use spaces instead of tabs
  set expandtab
  exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
  set list
endfun
autocmd BufRead,BufNewFile * call ShowWhitespace()

" Automatically remove trailing whitespace on write.
autocmd BufWritePre * :%s/\s\+$//e

" Make .aspx files highlight and indent as html files.
autocmd BufRead,BufNewFile *.aspx set filetype=html

" Fix backspace in cygwin.
if has('unix')
  let s:uname = system('uname -o')
  if s:uname == "Cygwin\n"
    set backspace=indent,eol,start
  endif
endif

" If buffer modified, update any 'Last modified: ' in the first 20 lines.
" 'Last modified: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Last modified: \).*#\1' .
          \ strftime('%a %b %d, %Y  %I:%M%p') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun
autocmd BufWritePre * call LastModified()

" Turn on line numbers
" run "set number!" to turn that off.
set number

" Show the bottom status bar always.
set laststatus=2

" Make my localdeploy script run every time I write to my JS or ASPX file.
autocmd BufWritePost SetupPolling.* !./localdeploy.sh

" Go Language vim compiler plugin
"autocmd FileType go compiler go

" Go language gofmt
"autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Set up a absolute to relative line number toggle.
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" Map ctrl-s to save.
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" Map ctrl-t to open a new tab.
map <C-t> <esc>:tabnew<CR>

" Remap my leader to comma.
let mapleader=","

map <leader>gf :Fmt<CR>
map <leader>fmt gg=G

" Move the default location for swap files.
set dir=~/.tmp

" Map F8 to open the tagbar window.
map <F8> <esc>:TagbarToggle<CR>

" Map F7 to open nerdtree.
map <F7> <esc>:NERDTreeToggle<CR>

" Tagbar config for gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }


" Hit leader-m to preview the markdown file in remarkable.
function! OpenCurrentFileInBrowser()
  " Actually open the file in chrome.
  :silent execute "!/usr/bin/google-chrome-stable %"

  " Fix empty vim window by forcing a redraw
  :redraw!
endfun

augroup filetype_markdown
  autocmd!
  autocmd BufNewFile,BufRead *.md set filetype=markdown

  autocmd FileType markdown nnoremap <leader>m :call OpenCurrentFileInBrowser()<CR>
augroup END

" Necessary to have a grey highlight on the current line.
set t_Co=256
silent! colorscheme atom-dark-256
set cursorline
highlight CursorLine cterm=NONE ctermbg=236 ctermfg=NONE

" Automatically close the 'preview' window when leaving insert mode.
let g:ycm_autoclose_preview_window_after_insertion = 1

" Turn on paste toggle key with some feedback from vim.wikia.com
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
