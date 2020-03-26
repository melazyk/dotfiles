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

" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylint']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']
" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 0

"nmap <buffer> <F5> :w<Esc>mwG:r!python %<CR>`

"set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
"set makeprg=python\ -c\ \"import\ sys;\ sys.stderr=sys.stdout;\ import\ %\"
"set makeprg=python\ %
"set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
"nmap <F9> :!python %<CR>

