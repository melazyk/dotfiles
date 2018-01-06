" Vim color file
set background=dark

if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
    syntax reset
    endif
endif
let g:colors_name="mydesert"

" highlight groups
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
"hi LineNr
"hi Visual
"hi VisualNOS
"hi WarningMsg
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip

" color terminal definitions
hi SpecialKey   ctermfg=darkgreen
hi NonText  cterm=bold ctermfg=darkblue
hi Directory    ctermfg=darkcyan
hi ErrorMsg cterm=bold ctermfg=7 ctermbg=1
hi WarningMsg cterm=bold ctermfg=7 ctermbg=darkred
hi IncSearch    cterm=NONE ctermfg=yellow ctermbg=green
" hi Search   cterm=NONE ctermfg=grey ctermbg=blue
hi Search   cterm=NONE ctermfg=yellow ctermbg=blue
hi MoreMsg  ctermfg=darkgreen
hi ModeMsg  cterm=NONE ctermfg=brown
"hi LineNr  ctermfg=3
hi LineNr ctermfg=darkgrey
hi Question ctermfg=green
hi StatusLine   cterm=bold,reverse
hi StatusLineNC cterm=reverse
hi VertSplit    cterm=reverse
hi Title    ctermfg=5
hi Visual   cterm=reverse
hi VisualNOS    cterm=bold,underline
hi WarningMsg   ctermfg=1
hi WildMenu ctermfg=0 ctermbg=3
hi Folded   ctermfg=darkgrey ctermbg=NONE
hi FoldColumn   ctermfg=darkgrey ctermbg=NONE
hi DiffAdd  ctermbg=4
hi DiffChange   ctermbg=5
hi DiffDelete   cterm=bold ctermfg=4 ctermbg=6
hi DiffText cterm=bold ctermbg=1
hi Comment  ctermfg=blue
hi Constant ctermfg=brown
hi Special  ctermfg=5
hi Identifier   ctermfg=6
hi Statement    ctermfg=3
hi PreProc  ctermfg=5
hi Type     ctermfg=2
hi Underlined   cterm=underline ctermfg=5
hi Ignore   cterm=bold ctermfg=7
hi Ignore   ctermfg=darkgrey
hi Error    cterm=bold ctermfg=7 ctermbg=1


"vim: sw=4
