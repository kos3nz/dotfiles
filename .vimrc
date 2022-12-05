set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

Plugin 'joshdick/onedark.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Enable syntax highlighting by default
syntax on

" Set theme
colorscheme onedark

" If you are having troubles with vim not detecting certain file types, add the following line
filetype on

" Show line numbers
set number

" Apply relative numbers to line numbers
set relativenumber

" Active mouse
set mouse=a

set tabstop=2
set shiftwidth=2
set autoindent
set whichwrap=h,l

" In insert mode, show a thin line as cursor
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set ttimeout
set ttimeoutlen=1
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set ttyfast

" In insert mode, move cursor to the start or end of the line by using Ctrl+a and Ctrl+e
imap <C-a> <ESC>I
imap <C-e> <ESC>A

" In insert or command mode, move normally by using Ctrl
inoremap <C-b> <Left>
inoremap <C-j> <Down>
inoremap <C-n> <Down>
inoremap <C-k> <Up>
inoremap <C-p> <Up>
inoremap <C-l> <Right>
inoremap <C-f> <Right>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>
cnoremap <C-f> <Right>

" Insert new line above without going into insert mode
" (uses mark o to return to the previous cursor column)
map <Enter> o<ESC>
map <S-Enter> O<ESC>

