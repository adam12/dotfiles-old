" defaults
" set autoindent
" set autoread
" set backspace=indent,eol,start
" set complete=-=i
" set display=lastline
" set encoding=utf8
" set formatoptions=tcqj
" set history=10000
" set hlsearch
" set incsearch
" set langnoremap
" set laststatus=2
" set list listchars=tab:> ,trail:-,nbsp:+
" set mouse=a
" set nocompatible
" set nrformats=hex
" set sessionoptions-=options
" set smarttab
" set tabpagemax=50
" set tags=./tags;,tags
" set ttyfast
" set viminfo+=!
" set wildmenu

execute pathogen#infect()
syntax on
filetype plugin indent on

if has("nvim")
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Backup/Swap settings
" Turn backup off, since most stuff is in SVN, git, etc. anyways
set nobackup
set noswapfile

" Appearance
set background=dark
colorscheme jellybeans

set title                   	" set window title
"set cursorline              	" highlight the line of the cursor
set ruler                   	" show the cursor position all the time
"set relativenumber          	" show relative numbers from cusor in gutter
set showcmd                 	" show partial commands below the status line

" Text Formatting
set list                        " do we need this?
set nowrap			" don't wrap lines
set scrolloff=1             	" maintain 1 line above cursor
set sidescrolloff=5         	" maintain 5 columns to the left and right of the cursor

" Indent
set foldmethod=indent

" Searching
set smartcase			" case sensitive if one capital given

" Mappings
let mapleader=","

" New split window and switch to it
nnoremap <leader>w <C-w>v<C-w>l

" Toggle open/close fold
nnoremap <Space> za

" Strip trailing whitespace
nnoremap <leader>s :%s/\s\+$<CR>

" Yank to OSX pasteboard
vnoremap <leader>y "*y

" Disable entering 'Ex' mode
nnoremap Q <nop>

" Remap all arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

if has("autocmd")
    " Custom file settings

    " In Makefiles, use real tabs not tabs expanded to spaces
    autocmd FileType make setlocal noexpandtab

    " Configure Python for PEP8
    autocmd FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

    " Configure Ruby for community agreed settings
    autocmd FileType ruby setlocal softtabstop=2 shiftwidth=2 tabstop=2 expandtab

    " Vue
    autocmd BufNewFile,BufReadPost *.vue setlocal filetype=html

    " Ruby-syntax files
    autocmd BufNewFile,BufReadPost {Vagrantfile,Guardfile,Capfile,Thorfile,pryrc,config.ru} setlocal filetype=ruby

    autocmd FileType gitcommit setlocal spell

    " Autorun Neomake after saving
    autocmd! BufWritePost * Neomake
endif

" Vim Test settings
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Ctrl-p bindings
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>f :CtrlPMUFiles<CR>

let test#strategy = "neoterm"
