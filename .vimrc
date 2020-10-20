" VIM Configuration File
" Description: Optimized for C/C++ development, but useful also for other things.
" Author: Norik Yenokyan


"" For Redhat Based systems """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible	" Use Vim defaults (much better!)
filetype plugin indent on " enable filetype dectection and ft specific plugin/indent

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

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on " Switch syntax highlighting on
  set hlsearch " switch on highlighting the last used search pattern
endif

" no bells
set noerrorbells visualbell t_vb=
autocmd VimEnter * set visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set t_BE=

" sets file format to unix
set ff=unix


"" color scheme """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
" colorscheme molokai

"" Guideline
set colorcolumn=121
highlight ColorColumn ctermbg=196


"" Highlight current line """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cursorline " highlight current line
" set cursorcolumn " highlight current column
highlight LineNr term=bold cterm=NONE ctermfg=59 ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE " Highlight cursor line
highlight CursorLine cterm=NONE ctermbg=234 ctermfg=NONE                                         " Highlight number of cursor line
highlight CursorLineNR cterm=NONE ctermfg=NONE ctermbg=234 ctermfg=196                           " Highlight number of cursor line
set showbreak=\\                                                                                 " show '\' to the end of break line


"" Highlight special characters """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight Comment ctermfg=240                  " Highlight comments
highlight SpecialKey ctermfg=240 guifg=#649A9A " Highlight color of special characters
highlight NonText ctermfg=240                  " Highlight color of special characters
highlight Search ctermfg=black ctermbg=white   " Highlight color of found items


"" Whitespaces """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set listchars=eol:¬,tab:\|·,trail:~,extends:>,precedes:<,space:· " Whitespace characters
" set list                                                         " Show withespaces

" Show trailing whitespaces
highlight ExtraWhitespace ctermbg=196 guibg=red
match ExtraWhitespace /\s\+$/
" Show trailing whitespaces only in C style languages
let c_space_errors=1


"" Search """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch                     " enable increase search
" set highlight                     " conflict with highlight current line
set ignorecase                    " Always case-insensitive search
set smartcase                     " Enable smart-case search, case sensitivity is on when uppercase exists
" set tags=./tags,./../../tags,tags " for ctags
set tags=./tags;/                 " This will look in the current directory for 'tags', and work up the tree towards root until one is found.
set cscopetag                     " CScope


"" Editor settings """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set history=1000               " maximum number of history
" set nofoldenable               " disable folding"
set confirm                    " prompt when existing from an unsaved file
set backspace=indent,eol,start " More powerful backspacing
set t_Co=256                   " Explicitly tell vim that the terminal has 256 colors "
" set mouse=a                    " use mouse in all modes
" set mouse=v                    " use mouse in visual mode (not normal,insert,command,help mode
set report=0                   " always report number of lines changed                "
set nowrap                     " dont wrap lines
set scrolloff=5                " 5 lines above/below cursor when scrolling
set number                     " show line numbers
set relativenumber             " show relativenumber
set showmatch                  " show matching bracket (briefly jump)
set showcmd                    " show typed command in status bar
set wildmenu                   " visual autocomplete for command menu
set title                      " show file in titlebar
set lazyredraw                 " redraw only when we need to.
set confirm                    " get a dialog when :q, :w, or :wq fails
" set nobackup                   " no backup~ files. I will not turn this on
" set noswapfile                 " no swapfiles. I will not turn this on. This can save your life.
set ruler                      " displays the line number, the column number, the virtual column number
set viminfo='20,\"500          " remember copy registers after quitting in the .viminfo file -- 20 jump links, regs up to 500 lines'
set hidden                     " remember undo after quitting
set history=150                " keep 50 lines of command history
set virtualedit=onemore        " allow to go one character behind the end of the line
set laststatus=2               " use 2 lines for the status bar
set matchtime=2                " show matching bracket for 0.2 seconds
set directory=$HOME/.vim/tmp   " move swp file to /tmp
set exrc                       " forces Vim to source .vimrc file if it present in working directory
set secure                     " restrict usage of some commands in non-default .vimrc files

set foldmethod=syntax          " fold using syntax
" set foldmethod=indent          " fold using indentation
set foldlevel=99
set clipboard=unnamed          " use default clipboard

set fillchars+=stlnc:-,fold:-,diff:-,vert:│ " " make splitted windows nicer

set comments=sl:/*,mb:\ *,elx:\ */ " intelligent comments

"" Automatically add interpreter path for new files
autocmd BufNewfile *.pl call append(0,'#!/usr/bin/perl')
autocmd BufNewfile *.py call append(0,'#!/usr/bin/python')
autocmd BufNewfile *.sh call append(0,'#!/bin/bash')

"" Default Indentation """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent     " use indentation of previous line
set expandtab      " expand tab to space
" set noexpandtab    " use tabs instead of spaces
set smartindent    " use intelligent indentation for C
set tabstop=4      " tab width
set softtabstop=4  " backspace width
set shiftwidth=4   " indent width
set smarttab       " insert tabs on the start of a line according to shiftwidth, not tabstop
set textwidth=120  " wrap lines at 120 chars. 80 is look dinosaur with nowadays displays.
set cindent        " configurable indentation for C, don't be lazy google for new options
set cinoptions=g-1 " indentation option
set cinoptions=N-s " indentation option


"" Python settings """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
scriptencoding utf-8
set encoding=utf-8


"" Mappings """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap jj <ESC>

" Jump over split windows without extra 'w'
map <C-h> <c-W>h
map <c-j> <c-W>j
map <c-k> <c-W>k
map <C-l> <C-W>l

nnoremap <C-left> :tabprevious<CR> " Ctrl-Left jump to previous tab
nnoremap <C-right> :tabnext<CR> " Ctrl-Right jump to next tab

nnoremap <C-down> :bprevious<CR> " Ctrl-Down jump to previous buffer
nnoremap <C-up> :bnext<CR> " Ctrl-Up jump to next buffer

set splitbelow " split new windows below
set splitright " split new windows right

nnoremap <space> za " space for folding instead of za

map ff :NERDTreeToggle<CR> " quick open for nerd tree just typeing 'ff'

map <silent> <C-k><C-d> mzgg=G`z " quick indent whole file presing Ctrl+k+d

" copy to clipboard in visual mode
vmap <C-c> "+y


"" Plugins """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Start Plug
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

" let g:airline#extensions#tabline#show_buffers = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
" let g:airline_skip_empty_sections = 1

" enable if no powerline fonts
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
" Plug 'ycm-core/YouCompleteMe'
" Plug 'zxqfl/tabnine-vim'
"" Nerd Tree

Plug 'jeffkreeftmeijer/vim-numbertoggle'

let NERDChristmasTree=0
let NERDTreeWinSize=30
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
" let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos = "left"

" nerdcommenter
let NERDSpaceDelims=1
" nmap <D-/> :NERDComToggleComment<cr>
let NERDCompactSexyComs=1


call plug#end()

set statusline+=%1*\ %<%F\

"" Automatically searches word under cursor
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

set guicursor=

if has("gui_running")
    " set textwidth=80 " allow max 80 symbols per line
    set lines=40     " vertical size of the window
    set columns=128  " horizontal size of the window
    if has("gui_gtk2")
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 12
    endif
endif
