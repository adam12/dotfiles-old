" Load pathogen from bundle path
runtime bundle/pathogen/autoload/pathogen.vim

" This must be first
set nocompatible
filetype off

" Essentials -------------------------------------------------
execute pathogen#infect()
syntax on
filetype plugin indent on
compiler ruby

set laststatus=2

" Basic options ----------------------------------------------
set encoding=utf-8
" Use Unix as the standard file type
set ffs=unix,dos,mac
set autoread                " auto-reload buffers when file changed on disk
set hidden                  " allow switching buffers without writing to disk
set visualbell
set ttyfast                 " send more characters for redraws
set splitbelow
set splitright
set autoindent
set copyindent


" Backup/Swap settings
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Fix backspace
set backspace=start,indent,eol
fixdel

" Display extra whitespace at the end of the line
set list listchars=tab:»·,trail:·

" Clipboard fix for OSX
"set clipboard=unnamed

" Folding
set foldmethod=marker
set foldlevelstart=99

" Enable exrc and make sure it's secure
set exrc
set secure

" Increase history
set history=1000

" Remap lader from \ to ,
let mapleader=","

" Appearance -------------------------------------------------
set title
set ruler                   " show the cursor position at all time
set cursorline              " highlight the line of the cursor
set showcmd                 " show partial commands below the status line
set relativenumber
set mouse=a
set ttymouse=xterm2
set background=dark

colorscheme apprentice

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" Text Formatting -------------------------------------------
set nowrap                  " don't wrap lines
"set smarttab                " sw at the start of the line, sts everywhere else
set showmatch               " show matching parenthesis

" Searching
set nohlsearch              " don't hightlight searches
set incsearch               " incremental searching
set ignorecase              " searches are case insensitive
set smartcase               " ... unless they contain at least one capital letter

" Make file/command completion useful
set wildmenu
set wildmode=list:longest,list:full
set complete=.,w,b
" ignore Rubinus, Sass cache files
set wildignore+=tmp/cache/**,*.rbc,.rbx,*.scssc,*.sassc
" ignore Bundler standalone/vendor installs & gems
set wildignore+=.bundle/*,*/vendor/bundle/*,*/vendor/cache/*,*/.sass-cache/*
set wildignore+=*~,tags,.git/*,.DS_Store

if has("autocmd")
  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab

  " Treat JSON files like JavaScript
  au BufRead,BufNewFile *.json set ft=javascript

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif

  " mark Jekyll YAML frontmatter as comment
  au BufNewFile,BufRead *.{md,markdown,html,xml,erb} sy match Comment /\%^---\_.\{-}---$/

  au FileType ruby set sw=2 sts=2 et

  " Save when losing focus
  au FocusLost * :silent! wall

  " Resize splits when the window is resized
  au VimResized * :wincmd =

  augroup ft_ruby
    au!
    " au FileType ruby setlocal foldmethod=syntax
    au BufNewFile,BufRead {Vagrantfile,Guardfile,Capfile,Thorfile,pryrc,config.ru} setlocal filetype=ruby
  augroup END

  " au FileType eruby setlocal ts=4 sts=4 sw=2 nolist
  " au FileType coffee setlocal ts=2 sts=2 sw=2 et
  au FileType xhtml,html,htm,php,xml setlocal ts=4 sw=4 sts=4 et
  au BufEnter *.ldg,*.ledger setlocal ft=ledger fp=ledger\ -f\ -\ -S\ d\ print

  " au FileType go autocmd BufWritePre <buffer> Fmt
  au FileType go set makeprg=go\ build nolist

  au FileType qf set nolist

  " Vue
  autocmd BufNewFile,BufReadPost *.vue set filetype=html
endif

" Mappings -----------------------------------------------------

" Remap all arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" ,v to reselect text that was just pasted
nnoremap <leader>v V`]

" ,ev to open $MYVIMRC in a virtical split
" nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>

nnoremap <silent> <leader>ew :Explore<CR>

" Quicker escape: jj in insert mode to escape
inoremap jj <ESC>

" New split window and switch to it
nnoremap <leader>w <C-w>v<C-w>l

" Space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" Yank to OS X pasteboard
noremap <leader>y "*y"

" Faster indentation
nnoremap > >>
nnoremap < <<

" Paste from OS X pasteboard without messing up indent
" nnoremap <leader>p :set paste<CR>"*p<CR>:set nopaste<CR>
" nnoremap <leader>P :set paste<cr>"*P<CR>:set nopaste<CR>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Spell checking -----------------------------------------------
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
"
" " Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Plugin settings ----------------------------------------------
let g:netrw_dirhistmax = 0

nnoremap <C-p> :<C-u>Unite file_rec buffer<CR>
nnoremap <space>/ :<C-u>Unite grep:.<CR>
nnoremap <leader>f :<C-u>Unite -start-insert file<CR>
nnoremap <leader>s :%s/\s\+$<CR>

" Airline Settings
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:vimpipe_invoke_map="<Leader>r"
let g:vimpipe_close_map="<Leader>p"
