""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required
set hidden
set history=10000
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase
set cursorline
set cmdheight=1
set switchbuf=useopen
set showtabline=2
set winwidth=79
set scrolloff=3
set t_Co=256
syntax enable
syntax on
filetype plugin indent on
set backspace=indent,eol,start
set expandtab
set wildmode=longest,list
set wildmenu
let mapleader=","
set timeout timeoutlen=1000 ttimeoutlen=100
set autoread
set relativenumber
set gdefault
set smartindent

" UTF-8
set enc=utf-8
set fileencoding=utf-8


" Don't make backups at all
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
no <down> ddp
no <up> ddkP
no <right> <Nop>
no <left> <Nop>

"switch tabs quickly
imap <C-S-Tab> <ESC>:tabprevious<CR>
nnoremap <C-S-Tab> :tabprevious<CR>
map <C-S-Tab> :tabprevious<CR>
nnoremap <C-Tab> :tabnext<CR>
imap <C-Tab> <ESC>:tabnext<CR>
map <C-Tab> :tabnext<CR>

" Quickly edit & source .vimrc
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>ev :e $MYVIMRC<CR>

" kill search highlight
nnoremap <leader><space> :noh<cr>

" quickly switch to corresponding tag
nnoremap <tab> %
vnoremap <tab> %

" delete all trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

"Ack
nnoremap <leader>a :Ack

"Open new vertical split and go to it
nnoremap <leader>w <C-w>v<C-w>l

"Navigate Splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"Add new lines without switching to them
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Center screen on search result
nmap <space> zz
nmap n nzz
nmap N Nzz

" Replace word under cursor
nnoremap <Leader>s :%s/<C-r><C-w>

" space to fold
nnoremap <space> za
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jump to last cursor position unless it's invalid or in an event handler
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

" associate *.foo with php filetype
au BufRead,BufNewFile *.hbs setfiletype mustache
au BufNewFile,BufRead *.json setfiletype javascript
au BufNewFile,BufRead *.boot setfiletype clojure

" show line numbers in insert mode
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CURSOR
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"set guicursor=n-v-c:block-Cursor
"set guicursor+=n-v-c:blinkwait7000
"set guicursor+=i:ver100-iCursor
"set guicursor+=i:blinkon0
"if &term =~ "xterm\\|rxvt"
"  " use an red cursor in insert mode
"  let &t_SI = "\<Esc>]12;red\x7"
"  " use a white cursor otherwise
"  let &t_EI = "\<Esc>]12;white\x7"
"  silent !echo -ne "\033]12;red\007"
"  " reset cursor when vim exits
"  autocmd VimLeave * silent !echo -ne "\033]112\007"
"  " use \003]12;gray\007 for gnome-terminal
"endif
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VUNDLE PLUGINS
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')


Plug 'gmarik/Vundle.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wincent/command-t'

Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/syntastic', { 'for': ['javascript', 'javascript.jsx', 'clojure', 'python'] }
Plug 'isRuslan/vim-es6'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'ervandew/supertab'
Plug 'easymotion/vim-easymotion'

" Python
Plug 'davidhalter/jedi-vim'
" Plug 'klen/python-mode'

""""" Clojure
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'
"Plug 'venantius/vim-cljfmt'
Plug 'kien/rainbow_parentheses.vim'
Plug 'altercation/vim-colors-solarized'

call plug#end()



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configuration
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" jedi-vim
let g:jedi#popup_on_dot = 0
autocmd FileType python setlocal completeopt-=preview


"Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:javascript_conceal_return     = "⇚"
let g:javascript_conceal_function   = "ƒ"

let g:airline_powerline_fonts=1

" Python
let python_highlight_all=1

" JSX Support
let g:jsx_ext_required = 0
let g:javascript_enable_domhtmlcss = 1
let g:syntastic_javascript_checkers = ['eslint', 'jsxhint']
let g:syntastic_python_checkers = ['pyflakes']

set wildignore=*.o,*.obj,.git,.DS_Store,.gitkeep
let g:CommandTWildIgnore=&wildignore . ",*bower_components/*,*node_modules/*,*tmp/*,*dist/*,*target/*,*.jpg,*.png,*.ico,bundle/*,out/*,target/*,old/*,resources/unpacked/*"

" Unlock for funky coloring of brackets etc
"Plugin 'jelera/vim-javascript-syntax'

map <c-f> :call JsBeautify()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
let g:solarized_termtrans= 1
"colorscheme Monokai
colorscheme solarized
