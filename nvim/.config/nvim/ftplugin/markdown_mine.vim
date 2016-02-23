" Custom mapping for Markdown files to support Todo Lists
" <leader>x to mark complete
" <leader>o to mark in progress
" <leader>b to mark won't do/blocking
" <leader><space> to mark new
"
:map <buffer> <leader>x        :.s:\[.\]:\[x\]<cr>:let @/ = ""<cr><cr>
:map <buffer> <leader>o        :.s:\[.\]:\[o\]<cr>:let @/ = ""<cr><cr>
:map <buffer> <leader>b        :.s:\[.\]:\[-\]<cr>:let @/ = ""<cr><cr>
:map <buffer> <leader><space>  :.s:\[.\]:\[ \]<cr>:let @/ = ""<cr><cr>
