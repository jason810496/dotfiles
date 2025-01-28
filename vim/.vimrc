set shell=zsh
set history=1000


filetype on
filetype plugin on
filetype indent on


set autoread
au FocusGained,BufEnter * checktime




set relativenumber
set cursorline

syntax on
set incsearch
set hlsearch



set showmatch
set mat=2

set smarttab

set shiftwidth=4
set tabstop=4

set lbr
set tw=500

set ai 
set si 
set wrap 


set background=dark
set termguicolors
colorscheme deep-space


nmap <C-n> :noh<CR>
