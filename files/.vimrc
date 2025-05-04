" ==================================================
"                     .vimrc
" Personal Vim Configuration - Enhance Your Editing
" ==================================================

" General settings
set nocompatible
set nobackup
set nowritebackup
set noswapfile
set hidden
set number
set autoindent
set smartindent
set smarttab
"set cursorline
set expandtab
set tabstop=4       " Number of spaces tabs count for
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent
set laststatus=2
set mouse=a
set encoding=utf-8
set clipboard=unnamedplus
set background=dark
set t_Co=256
set backspace=2
syntax on
syntax enable
filetype indent plugin on

" Enhanced command-line completion
set wildmenu

" File type specific settings
autocmd FileType yaml setlocal expandtab tabstop=2 shiftwidth=2 autoindent
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 autoindent
autocmd FileType sh setlocal expandtab tabstop=4 shiftwidth=4 autoindent
autocmd FileType markdown setlocal wrap
autocmd FileType puppet setlocal tabstop=8 expandtab shiftwidth=2 softtabstop=2

" Security settings for sensitive files
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
au BufWrite /private/etc/pw.* set nowritebackup nobackup

" Key mappings for productivity
let mapleader=','
nnoremap <F5> "=strftime('%x %X')<CR>P
inoremap <F5> <C-R>=strftime('%x %X')<CR>
nnoremap gx :!xdg-open <cWORD> &<CR><CR>
nnoremap gp :bp<CR>
nnoremap gn :bn<CR>
nnoremap gl :ls<CR>