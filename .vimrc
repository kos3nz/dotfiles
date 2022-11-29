" Enable syntax highlighting by default
syntax on

colorscheme slate

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

