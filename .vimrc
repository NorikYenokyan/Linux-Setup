if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more " than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

"-------------------------------------------------------------
"Use Vim defaults (much better!)
set nocompatible
"allow backspacing over everything in insert mode
set bs=indent,eol,start
" no bells
set noerrorbells visualbell t_vb=
autocmd VimEnter * set visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
"auto append
autocmd BufNewfile *.pl call append(0,'#!/usr/bin/perl')
autocmd BufNewfile *.py call append(0,'#!/usr/bin/python')
autocmd BufNewfile *.sh call append(0,'#!/bin/bash')
"costom swapfile path
set directory=$HOME/.vim/swapfiles//
"show space errors
let c_space_errors=1
inoremap jj <ESC>

let c_space_errors=1
"set autowrite
set ff=unix
set t_Co=256
map <silent> <C-k><C-d> mzgg=G`z
map ff :NERDTreeToggle<CR>
set colorcolumn=121
highlight ColorColumn ctermbg=196
set hlsearch
set t_BE=
highlight LineNr term=bold cterm=NONE ctermfg=59 ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
set cursorline
hi CursorLine cterm=NONE ctermbg=234 ctermfg=NONE
highlight CursorLineNR ctermbg=234 ctermfg=196
set showbreak=\\
highlight Comment ctermfg=240
highlight SpecialKey ctermfg=240 guifg=#649A9A
highlight NonText ctermfg=240
highlight Search ctermfg=black ctermbg=white

set listchars=eol:¬,tab:\|·,trail:~,extends:>,precedes:<,space:·
"set list

set cpoptions+=n
set nocompatible
set incsearch
set ignorecase
syntax enable
set autoindent
set path+=**
set showmatch
set hidden
set showcmd
set exrc
set secure
set ttyfast
set wildmenu
set number
set scrolloff=5
set nostartofline

"set relativenumber
set cindent
set cinoptions=g-1
set cinoptions=N-s
set softtabstop=4
"set noexpandtab
set expandtab
set shiftwidth=4
set tabstop=4
set ruler

set tags=./tags,./../../tags,tags

inoremap {<CR> {<CR>}<ESC>O
map <C-h> <c-W>h
map <c-j> <c-W>j
map <c-k> <c-W>k
map <C-l> <C-W>l
nnoremap <C-left> :tabprevious<CR>
nnoremap <C-right> :tabnext<CR>
nnoremap <C-down> :bprevious<CR>
nnoremap <C-up> :bnext<CR>
set splitbelow
set splitright
set foldmethod=syntax
"set foldmethod=indent
set foldlevel=99
nnoremap <space> za

"Show trailing whitespaces
highlight ExtraWhitespace ctermbg=196 guibg=red
match ExtraWhitespace /\s\+$/

let mysyntaxfile='/home/noriky/.vim/syntax/doxygen_load.vim'

set clipboard=unnamed

" -------- vim plug --------
call plug#begin('~/.vim/plugged')

Plug 'bfrg/vim-cpp-modern'
let g:cpp_concepts_highlight = 1
let c_no_curly_error = 1

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"let g:airline_theme='papercolor'
"let g:airline_solarized_bg='dark'
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
set noshowmode
"let g:bufferline_echo = 0
let g:airline#extensions#tabline#formatter = 'default'

"let g:airline#extensions#tabline#show_buffers = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
"let g:airline_skip_empty_sections = 1

" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif


Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'ycm-core/YouCompleteMe'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

"Plug 'zxqfl/tabnine-vim'
"set fillchars+=stlnc:-,fold:-,diff:-
set fillchars+=stlnc:-,fold:-

call plug#end()


set statusline+=%1*\ %<%F\
" set updatetime=10
"
" function! HighlightWordUnderCursor()
"     if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
"         exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/'
"     else
"         match none
"     endif
" endfunction
"
" autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()
"

set mouse=a

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0

set guicursor=

if has("gui_running")
    " set textwidth=80 " allow max 80 symbols per line
    set lines=40     " vertical size of the window
    set columns=128  " horizontal size of the window
    if has("gui_gtk2")
        set guifont=Hack\ 9
    else
        set guifont=Hack\ 9
    endif
end

