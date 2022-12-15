call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'catppuccin/vim', { 'as': 'catppuccin'}

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" Enable syntax highlighting by default
syntax on

" Set theme
colorscheme catppuccin_mocha

" If you are having troubles with vim not detecting certain file types, add the following line
filetype on

" Show line numbers
set number

" Apply relative numbers to line numbers
" set relativenumber

" Active mouse
set mouse=a

set tabstop=2
set shiftwidth=2
set autoindent
set whichwrap=h,l

" In insert mode, show a thin line as cursor
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END
set ttimeout
set ttimeoutlen=1
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

