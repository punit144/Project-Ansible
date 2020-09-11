filetype off
filetype plugin indent on
syntax on

" Pathogen Configuration for autoload plugins during startup
set nocp
set rtp+=~/.vim/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

"Global Mapping
let mapleader=","

"Local Mappings
"Buffer Explorer
map <leader>e :Explore<cr>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Close the current buffer
map <leader>c :bd<cr>

map <leader>b :bnext<cr>

inoremap <leader><leader> <Esc>
vnoremap <leader><leader> <Esc>

nnoremap W :wq!<cr>
nnoremap Q :q!<cr>
nnoremap S :w<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Run Python Code from Vim
autocmd FileType python map <buffer> <Leader>. :w<CR>:ter python3 %<CR>
autocmd FileType python imap <buffer> <Leader>. <esc>:w<CR>:ter python3 %<CR>

" Python Syntax Checker Mapping
autocmd FileType python map <buffer> C :call flake8#Flake8()<CR>

" Tag Bar
nmap <leader>; :TagbarToggle<CR>

" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233

" Pep8 Indentation
" au BufNewFile,BufRead *.py
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set fileformat=unix

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" UTF Support
set encoding=utf-8

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color schemes
set t_Co=256
set background=dark
color gruvbox

let g:ctrlp_max_height = 5
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" Status line Configuration VimAirline
" Always show the status line
set laststatus=2

" Synatatix Python Checker
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%{FugitiveStatusline()}

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
let g:SimpylFold_docstring_preview = 1

" Vim arline tab bar enable
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='badwolf'

set backspace=indent,eol,start  " more powerful backspacing
" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml 
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set foldmethod=indent
set foldlevel=20

" For timeout settings
set timeoutlen=1000
set ttimeoutlen=0
set splitbelow
