" Remove ALL autocommands for the current group.
autocmd!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd's
" source the vimrc file after saving it
autocmd bufwritepost .vimrc source $MYVIMRC


set nocompatible

filetype indent on
filetype on
filetype plugin on
filetype plugin indent on

set viminfo='100,%,/50,:50,<50,h

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"        ___                                            "
"       /\_ \                    __                     "
"  _____\//\ \    __  __     __ /\_\    ___     ____    "
" /\ '__`\\ \ \  /\ \/\ \  /'_ `\/\ \ /' _ `\  /',__\   "
" \ \ \L\ \\_\ \_\ \ \_\ \/\ \L\ \ \ \/\ \/\ \/\__, `\  "
"  \ \ ,__//\____\\ \____/\ \____ \ \_\ \_\ \_\/\____/  "
"   \ \ \/ \/____/ \/___/  \/___L\ \/_/\/_/\/_/\/___/   "
"    \ \_\                   /\____/                    "
"     \/_/                   \_/__/                     "
"                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if v:version > 704
    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

    Plugin 'Valloric/YouCompleteMe'
    Plugin 'klen/python-mode'
    Plugin 'scrooloose/syntastic'
    Plugin 'kevinw/pyflakes'
    Plugin 'scrooloose/nerdtree'
    Plugin 'jistr/vim-nerdtree-tabs'
    Plugin 'vim-scripts/cscope.vim'
    Plugin 'simplyzhao/cscope_maps.vim'
    " Plugin 'vim-scripts/taglist.vim'

    " All of your Plugins must be added before the following line
    call vundle#end()            " required
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
let NERDTreeShowLineNumbers=1

" Man viewer plugin
runtime ftplugin/man.vim

" Buffers settings
set autowriteall
set hidden

function! MyTabLine()
    let tabline = ''
    for i in range(tabpagenr('$'))
        if i + 1 == tabpagenr()
            let tabline .= '%#TabLineSel#'
        else
            let tabline .= '%#TabLine#'
        endif

        let tabline .= '%' . (i + 1) . 'T'

        let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} |'
    endfor

    let tabline .= '%#TabLineFill#%T'

    if tabpagenr('$') > 1
        let tabline .= '%=%#TabLine#%999XX'
    endif

    return tabline
endfunction

function! MyTabLabel(n)
    let label = ''
    let buflist = tabpagebuflist(a:n)

    let label = substitute(bufname(buflist[tabpagewinnr(a:n) - 1]), '.*/', '', '')

    if label == ''
      let label = '[No Name]'
    endif

    let label .= ' (' . a:n . ')'

    for i in range(len(buflist))
        if getbufvar(buflist[i], "&modified")
            let label = '[+] ' . label
            break
        endif
    endfor

    return label
endfunction


function! Help()
    let help_prefix = 'help '
    let word = expand("<cword>")
    let query = help_prefix . word
    execute query
endfunction

function! OpenDual()
    let file_name = expand("%:r")
    let ext = expand("%:e")
    let query = file_name.ext
    if ext == "cpp"
        let query = "tabnew ".file_name.".h"
    endif
    if ext == "h"
        let query = "tabnew ".file_name.".cpp"
    endif
    exec query
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing
set nohlsearch
set incsearch
set ignorecase
set smartcase

set autoindent
set scrolloff=3
set number
set wrap
" Размер табулации по умолчанию
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
" no new tab after scope declarations
set cinoptions+=g0
" no new tab after namespace
set cinoptions+=N-s

set foldmethod=syntax
set foldlevel=25

syntax enable
set background=light

vnoremap < <gv
vnoremap > >gv

set showmatch
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Interface
set backspace=2
set termencoding=utf-8
syntax on
" Show the line and column number of the cursor position, separated by a comma.
set ruler

" Show things that are normally not visible
set list
" Show tilda instead of trailing whitespace
set listchars=trail:~,tab:>-

set laststatus=2
set wildmenu
set showcmd

set vb t_vb=            " Disable beep
au GUIEnter * set t_vb=

set nosplitbelow

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hotkeys"
imap <C-j> <Esc>:tabprevious<CR>i
nmap <C-j> :tabprevious<CR>
imap <C-k> <Esc>:tabnext<CR>i
nmap <C-k> :tabnext<CR>
imap <C-h> <Esc>:tabnew<Space>
nmap <C-h> :tabnew<Space>
nmap <F7> :call Help()<CR>
nmap <F6> :call OpenDual()<CR>
imap <C-g> <Esc>:YcmCompleter GoTo<CR>
nmap <C-g> <Esc>:YcmCompleter GoTo<CR>


" F2 - быстрое сохранение
nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>v
imap <F2> <esc>:w<cr>i

nnoremap <silent> <C-8> :TlistToggle<CR>
inoremap <silent> <C-8> <Esc>:TlistToggle<CR>
nnoremap <silent> <C-9> :MarksBrowser<CR>
inoremap <silent> <C-9> <Esc>:MarksBrowser<CR>
nnoremap <silent> <C-0> :BufExplorer<CR>
inoremap <silent> <C-0> <Esc>:BufExplorer<CR>

set pastetoggle=<C-F11>

nnoremap : q:i
nmap <F9> <ESC>:bd<CR>
nmap <C-l> :TlistOpen<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
colorscheme desert
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=LightBlue
set hlsearch
hi Search ctermfg=7 ctermbg=3

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings for different filetypes
autocmd BufReadPost *.[ch] call On_C_Load()
autocmd BufReadPost *.{[Hh][Tt][Mm]?},*.tpl call On_HTML_Load()
autocmd BufReadPost *.phtml set filetype=php
au! BufRead,BufNewFile *.json setfiletype json
au! BufRead,BufNewFile *.rsl setfiletype rsl
au! BufRead,BufNewFile *.ooc setfiletype ooc
" XML folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

function! On_C_Load()
    set cindent
    set formatoptions=cqr
endfunction

function! On_HTML_Load()
    runtime! syntax/html.vim
endfunction

" Tag files
set tags=tags,../tags,../../tags,../../../tags

let c_no_curly_error=1

" Highlighting bad formatting.
highlight BAD_FORMATTING cterm=bold ctermfg=Cyan
autocmd Syntax * syntax match BAD_FORMATTING /\s\+$\|\t\|.\{80\}/ containedin=ALL

" Make make parallel
set makeprg=make\ -j

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Local variables settings
set path=.,genfiles,include,/usr/include/c++/4.6.3,/usr/include/c++/4.6.3/x86_64-unknown-linux-gnu,/usr/include/c++/4.6.3/backward,/usr/lib/gcc/x86_64-unknown-linux-gnu/4.6.3/include,/usr/local/include,/usr/lib/gcc/x86_64-unknown-linux-gnu/4.6.3/include-fixed,/usr/include,,
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

