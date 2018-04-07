syntax on
set wrap
set autoindent
set number

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set nohlsearch
set foldcolumn=3
color mydesert

filetype on
filetype plugin on
filetype indent on

au FileType javascript call JavaScriptFold()

let g:ftwithtabs = [ 'go' ]

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'majutsushi/tagbar'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
call plug#end()


" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

function! InsertTabWrapper()
     let col = col('.') - 1
     if !col || getline('.')[col - 1] !~ '\k'
     return "\<tab>"
     else
     return "\<c-p>"
     endif
endfunction


if index(g:ftwithtabs,&ft) < 0
    imap <tab> <c-r>=InsertTabWrapper()<cr>
endif

set complete=""
set complete+=.
set complete+=k
set complete+=b
set complete+=t

" StripTrailingWhitespaces
function! StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    %s/\s\t\s\+$/\s\{6}/e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

set pastetoggle=,p

nmap ,tree :NERDTreeToggle<CR>
nmap ,tag :TagbarToggle<CR>
map <silent> ,s :call StripTrailingWhitespaces()<CR>
map <silent> ,n :let &number=1-&number \| let &foldcolumn=&number<CR>
map <buffer> <C-p> :setlocal paste! paste?<cr>

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala,go let b:comment_leader = '// '
autocmd FileType sh,ruby,python      let b:comment_leader = '# '
autocmd FileType conf,fstab          let b:comment_leader = '# '
autocmd FileType tex                 let b:comment_leader = '% '
autocmd FileType mail                let b:comment_leader = '> '
autocmd FileType vim                 let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

set foldmethod=syntax
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
"setlocal spelllang=ru_yo,en_us spell

if v:version > 702
    autocmd BufNewFile,BufRead * if index(g:ftwithtabs,&ft) < 0|let b:mtabaftersp=matchadd('ErrorMsg', '\t', -1)|endif
    " highlight trailing spaces
    autocmd BufNewFile,BufRead * let b:mtrailingws=matchadd('ErrorMsg', '\ \+$', -1)
    " highlight tabs between spaces
    autocmd BufNewFile,BufRead * let b:mtabbeforesp=matchadd('ErrorMsg', '\v(\t+)\ze( +)', -1)
    autocmd BufNewFile,BufRead * let b:mtabaftersp=matchadd('ErrorMsg', '\v( +)\zs(\t+)', -1)
    au BufReadPost *.html set filetype=javascript
endif

augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost * if &bin | %!xxd
    au BufReadPost * set ft=xxd | endif
    au BufWritePre * if &bin | %!xxd -r
    au BufWritePre * endif
    au BufWritePost * if &bin | %!xxd
    au BufWritePost * set nomod | endif
augroup END

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
