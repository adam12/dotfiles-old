" This must be first
set nocompatible

" Essentials -------------------------------------------------
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype on
filetype indent on
filetype plugin on
compiler ruby

set laststatus=2
set rtp+=~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim

" Basic options ----------------------------------------------
set encoding=utf-8
set autoread                " auto-reload buffers when file changed on disk
set hidden                  " allow switching buffers without writing to disk
set visualbell
set ttyfast                 " send more characters for redraws
set splitbelow
set splitright
set autoindent

" Backup/Swap settings
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

" Fix backspace
set backspace=start,indent,eol
fixdel

" Display extra whitespace at the end of the line
set list listchars=tab:»·,trail:·

" Clipboard fix for OSX
set clipboard=unnamed

" Folding
"set foldmethod=indent
set foldmethod=marker
set foldlevelstart=99

set shell=/bin/bash\ -l     " avoids munging PATH under zsh
let g:is_bash=1             " default shell syntax

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
set smarttab                " sw at the start of the line, sts everywhere else
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
  au BufNewFile,BufRead *.{md,markdown,html,xml} sy match Comment /\%^---\_.\{-}---$/


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
    au FileType ruby setlocal foldmethod=syntax
    au BufNewFile,BufRead {Vagrantfile,Guardfile,Capfile,Thorfile,pryrc,config.ru} setlocal filetype=ruby
  augroup END

  au FileType eruby setlocal ts=4 sts=4 sw=2 nolist
  au FileType coffee setlocal ts=2 sts=2 sw=2 et
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
nnoremap <leader>p :set paste<CR>"*p<CR>:set nopate<CR>
nnoremap <leader>P :set paste<cr>"*P<CR>:set nopaste<CR>

" Plugin settings ----------------------------------------------
let g:netrw_dirhistmax = 0
" let g:netrw_use_errorwindow = 0 " don't create a new window for error messages
let g:netrw_list_hide = '\~$,^tags$,^\.bundle/$,^\.git/$'
let g:ctrlp_root_markers = ['.git', 'tag']
let g:ackprg = 'ag --nogroup --nocolor --column'
