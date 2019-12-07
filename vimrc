"be iMproved, required
set nocompatible

filetype off "required
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/vundle'                      "vundle

Plugin 'scrooloose/nerdtree'                "Nerdtree

Plugin 'wesleyche/SrcExpl'                  "SrcExpl

Plugin 'taglist.vim'                        "taglist

Plugin 'wesleyche/Trinity'                  "trinity

Plugin 'MarcWeber/vim-addon-mw-utils'       "snipmate
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

call vundle#end()            " required

filetype plugin indent on    " required


"plugin shortcut"
nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TlistToggle<CR>
nmap <F9> :SrcExplToggle<CR><CR>
nmap <F10> :TrinityToggleAll<CR>


"nerdtree
let NERDTreeWinPos=1
let g:NERDTreeWinSize=25
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeNodeDelimiter = "\u00a0"

"SrcExpl
let g:SrcExpl_winHeight=7
let g:SrcExpl_pluginList = [
        \ "__Tag_List__",
        \ "_NERD_tree_",
        \ "Source_Explorer"
    \ ]
let g:SrcExpl_jumpKey = "<ENTER>"
let g:SrcExpl_gobackKey = "<SPACE>"
let g:SrcExpl_updateTagsKey = "<C-\>u" 

"taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_WinWidth=25
set ut=100



"show the syntax color"
syntax enable

"show the line number"
set number

"set encoding"
set encoding=utf-8

"not display the coordinate"
set noruler

"ignore the capital or lowercase when searching"
set ignorecase
set smartcase

"set autoindent"
set autoindent

"set the tab"
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab

"enable confirming"
set confirm

"record 100 commands"
set history=100

"show the command typed before"
set showcmd

"show the mode of vim"
set showmode

"not changing the line automatically"
set nowrap

"save automatically"
set autowrite

"using mouse to move the cursor"
set mouse=a

"set background color"
set bg=dark

"support 256 colors"
set t_Co=256

"cursorline"
set cursorline

" key mapping
inoremap {<CR> {<CR>}<Esc>ko

"recognize the filetype"
filetype indent on

"set tab for makefile"
autocmd FileType make setlocal noexpandtab shiftwidth=8 tabstop=8

"set copy & paste"
"test with vim --version | grep -clipboard"
"if +clipboard, then it supports"
set clipboard=unnamed



"vim-plug"
"call plug#begin('~/.vim/plugged')
"call plug#end()



"color configuration"
hi Type cterm=bold ctermfg=195
hi Normal ctermfg=249 ctermbg=233
hi String ctermfg=077
hi Comment ctermfg=117
hi PreProc ctermfg=220
hi Statement cterm=bold ctermfg=039

hi Number ctermfg=185
hi link Float Number
hi Boolean ctermfg=105
hi Character ctermfg=231

hi LineNr ctermfg=122
hi CursorLine cterm=none ctermbg=235
hi CursorLineNr cterm=bold ctermfg=226
hi StorageClass ctermfg=229
hi link Structure StorageClass



"status line"
 set statusline=
 set statusline+=%2*\ %<%F\                                " File+path
 set statusline+=%3*\ %=\ %{''.(&fenc!=''?&fenc:&enc).''}\ " Encoding
 set statusline+=%6*\ %5l,%3c\                             " RowColnumber
 hi User2 ctermfg=15  ctermbg=237
 hi User3 ctermfg=15  ctermbg=237
 hi User6 ctermfg=0  ctermbg=32
 set laststatus=2



"cscope & ctags settings
set cscopetag " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set csto=0
set tags=./tags,../tags

" add any cscope database in current directory
if filereadable("cscope.out")
    cs add cscope.out
" else add the database pointed to by environment variable
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif

" show msg when any other cscope db added
set cscopeverbose

" key mapping for cscope
"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   't'   text:   find all instances of the text under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'f'   file:   open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called: find functions that function under cursor calls
" You can use CTRL-T to go back to where you were before the search.

" jump to target directly
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" jump to target with a new vertical split window
nmap <C-\><C-\>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\><C-\>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\><C-\>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\><C-\>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\><C-\>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\><C-\>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\><C-\>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\><C-\>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

" update cscope automatically
fun! AutoUpdateCscopeAndCtags()
  let UpdateCscopeDB = 'cscope -Rbqk'
  let UpdateCtagsDB = 'ctags -R'
  let Res = system(UpdateCscopeDB)
  let Res = system(UpdateCtagsDB)
  unlet UpdateCscopeDB
  unlet UpdateCtagsDB
  unlet Res
  exe "cs reset"
endfun
nmap <C-\>u :call AutoUpdateCscopeAndCtags()<CR><CR>
