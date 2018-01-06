set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set softtabstop=4

set autoindent

let python_highlight_all = 1

set t_Co=256

autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
im :<CR> :<CR><TAB>

autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

set omnifunc=pythoncomplete#Complete

"nmap <buffer> <F5> :w<Esc>mwG:r!python %<CR>`

"set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
"set makeprg=python\ -c\ \"import\ sys;\ sys.stderr=sys.stdout;\ import\ %\"
"set makeprg=python\ %
"set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
"nmap <F9> :!python %<CR>

