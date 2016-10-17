autocmd BufEnter * lcd %:p:h

let g:tagbar_compact = 1
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_autopreview = 1
let g:tagbar_previewwin_pos = "rightbelow"
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let g:NERDTreeDirArrows=0

let g:tagbar_type_swift = {
  \ 'ctagstype': 'swift',
  \ 'kinds' : [
    \ 'n:Enums',
    \ 't:Typealiases',
    \ 'p:Protocols',
    \ 's:Structs',
    \ 'c:Classes',
    \ 'f:Functions',
    \ 'v:Variables',
    \ 'e:Extensions'
  \ ],
  \ 'sort' : 0
\ }

set nocompatible
set backspace=indent,eol,start
syntax on
filetype plugin indent on
set lazyredraw
set scrolloff=4
set number
set ls=2
set tabstop=4
set shiftwidth=4
set incsearch
set ruler
set nobackup
set ignorecase
set ttyfast
set smartindent
set nocindent
set softtabstop=4
set expandtab
set virtualedit=all
set notimeout
set ttimeout
set timeoutlen=50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/build/*,*/docs/*,*/Pods/*
set encoding=utf-8

:nmap n nzz
:nmap p pzz
:nmap <S-G> <S-G>zz

execute pathogen#infect()
map <C-N> :NERDTreeToggle<CR>
map <C-T> :CtrlP<CR>
nnoremap <F5> :GundoToggle<CR>
nnoremap <silent> <F6> :FixWhitespace<CR>
nmap <F8> :TagbarToggle<CR>

color default
set background=dark

