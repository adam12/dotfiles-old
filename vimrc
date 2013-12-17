" This must be first
set nocompatible
filetype off

" Essentials -------------------------------------------------
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'mileszs/ack.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-bundler'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-rhubarb'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-sensible'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-tbone'
Bundle 'tpope/vim-unimpaired'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'avakhov/vim-yaml'
Bundle 'tpope/vim-markdown'
Bundle 'duff/vim-scratch'
Bundle 'ap/vim-css-color'
Bundle 'scrooloose/nerdtree'
" Bundle 'spf13/PIV'
Bundle 'scrooloose/syntastic'
Bundle 'mustache/vim-mode'
Bundle 'bling/vim-airline'

syntax on
filetype plugin indent on
compiler ruby

set laststatus=2
" set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim

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
" set tabstop=4
" set shiftwidth=4


" Backup/Swap settings
" set backupdir=~/.vim/backup/
" set directory=~/.vim/backup/
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
"set foldmethod=indent
set foldmethod=marker
set foldlevelstart=99

" set shell=/bin/bash\ -l     " avoids munging PATH under zsh
" let g:is_bash=1             " default shell syntax
set shell=$SHELL\ -l

" Enable exrc and make sure it's secure
set exrc
set secure

" Increase history
set history=1000

" Remap lader from \ to ,
let mapleader=","

" Appearance -------------------------------------------------
set t_Co=256
set title
set ruler                   " show the cursor position at all time
set cursorline              " highlight the line of the cursor
set showcmd                 " show partial commands below the status line
set relativenumber
set mouse=a
set ttymouse=xterm2
set background=dark

colorscheme railscasts


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
set wildignore+=tmp/**,*.rbc,.rbx,*.scssc,*.sassc
" ignore Bundler standalone/vendor installs & gems
set wildignore+=*/.bundle/*,*/vendor/bundle/*,*/vendor/cache/*,*/.sass-cache/*

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


  au FileType ruby
        \ if expand('%') =~# '_test\.rb$' |
        \   compiler rubyunit | setl makeprg=testrb\ \"%:p\" |
        \ elseif expand('%') =~# '_spec\.rb$' |
        \   compiler rspec | setl makeprg=rspec\ \"%:p\" |
        \ else |
        \   compiler ruby | setl makeprg=ruby\ -wc\ \"%:p\" |
        \ endif
  au User Bundler
        \ if &makeprg !~# 'bundle' | setl makeprg^=bundle\ exec\  | endif

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
  au BufEnter *.ldg,*.ledger setlocal ft=ledger fp=ledger\ -f\ -\ print
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

" Paste from OS X pasteboard without messing up indent
nnoremap <leader>p :set paste<CR>"*p<CR>:set nopaste<CR>
nnoremap <leader>P :set paste<cr>"*P<CR>:set nopaste<CR>

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
" let g:netrw_use_errorwindow = 0 " don't create a new window for error messages
let g:netrw_list_hide = '\~$,^tags$,^\.bundle/$,^\.git/$'
let g:ctrlp_root_markers = ['.git', 'tag']
let g:ackprg = 'ag --nogroup --nocolor --column'

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
