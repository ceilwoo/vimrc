"--------------------------------------------------------------------------------
" Simple Vimrc v1.2
" by ceilwoo@gmail.com
"--------------------------------------------------------------------------------
" 适用于命令行vim，gvim，windows，mac os


"--------------------------------------------------------------------------------
" General
"--------------------------------------------------------------------------------
set number
" Ignore case when searching
set ignorecase
set linespace=2 
set fdm=marker
"
" Sets how many lines of history VIM has to remember
set history=700

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" hightlighting search result
set hlsearch 
" Makes search act like search in modern browsers
set incsearch

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Turn on the wild menu
set wildmenu

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

"--------------------------------------------------------------------------------
" Vundle Setting
"--------------------------------------------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Git plugin not hosted on GitHub
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/terryma/vim-multiple-cursors'
Plugin 'https://github.com/altercation/vim-colors-solarized.git'
Plugin 'https://github.com/ctrlpvim/ctrlp.vim'
Plugin 'https://github.com/majutsushi/tagbar.git'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
"Plugin 'altercation/vim-colors-solarized' "git://github.com/altercation/solarized.git

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"--------------------------------------------------------------------------------
" Encoding Setting
"--------------------------------------------------------------------------------
if has("gui_running") 
	set encoding=utf-8
	set termencoding=utf-8
	set fileencoding=utf-8
	set fileencodings=ucs-bom,utf-8,chinese,cp936,latin-1
if has("win32")
	set fileencoding=chinese
else
	set fileencoding=utf-8
endif

" Use Unix as the standard file type
set ffs=unix,dos,mac

let &termencoding=&encoding

"MENU LANGUAGE
source $VIMRUNTIME/delmenu.vim 
source $VIMRUNTIME/menu.vim
"CONSLE LANGUAGE
language messages zh_CN.utf-8
endif

"--------------------------------------------------------------------------------
" Visual mode related
"--------------------------------------------------------------------------------
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"--------------------------------------------------------------------------------
" Status Bar Setting
"--------------------------------------------------------------------------------
" Format the status line
"set statusline=[%F]%y%r%m%*%=[%l/%L;%c][%p%%] " status format
set statusline=\ %{HasPaste()}[%F]%y%r%m%h\ %w\ \ CWD:\ %r%{getcwd()}%h%=[%l/%L,%c][%p%%]
set laststatus=2    " always show the status bar
set ruler           " show current line

"--------------------------------------------------------------------------------
" programme setting
"--------------------------------------------------------------------------------
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

set smartindent
set autoindent

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=b,s,[,],<,>,h,l

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

set ai "Auto indent
set si "Smart indent
"set wrap "Wrap lines
:set nowrap

set linebreak
set autochdir
set equalalways
set matchpairs=(:),{:},[:],<:>

syntax enable
if has("gui_running") 
	set background=dark
	set guifont=Monaco:h13
	colorscheme solarized
	let g:solarized_termcolors=16
else
	colorscheme desert
endif

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"--------------------------------------------------------------------------------
" Quickfix window
"--------------------------------------------------------------------------------
command -bang -nargs=? QFix call QFixToggle(<bang>0)
nnoremap <leader>q :QFix<CR>

"--------------------------------------------------------------------------------
"tabpage setting
"--------------------------------------------------------------------------------
" Useful mappings for managing tabs
set guitablabel=%N/\ %t\ %M 
	augroup Tabs   
	nmap    ,tn    :tabnew<cr> 
	nmap    ,te    :tabedit
	nmap    ,tx    :tabedit .<cr>
	nmap    ,tf    :tabfirst<cr>
	nmap    ,tl    :tablast<cr>
	nmap    ,th    :tab help<cr>
	nmap    ,tm    :tabmove
augroup END

map <C-TAB> :tabn<CR>
imap <C-TAB> :tabn<CR>
nmap gf :tabedit <cfile><CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

"--------------------------------------------------------------------------------
" Handle common typos for :commands
"--------------------------------------------------------------------------------
command! Q  quit
command! W  write
command! Wq wq
"- this one won't work, because :X is already a built-in command
"- command! X  xit

"--------------------------------------------------------------------------------
" Helper functions
"--------------------------------------------------------------------------------
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen 10
        let g:qfix_win = bufnr("$")
    endif
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

"--------------------------------------------------------------------------------
" Plugin Setting 
"--------------------------------------------------------------------------------
cnoremap <C-n> :NERDTreeToggle<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "exit if only nerdtree window
let g:NERDTreeChDirMode=2 "show current folder

" ctrlp
let g:ctrlp_working_path_mode = 'ra'

" tagbar
nmap <F8> :TagbarToggle<cr>
"let tagbar_left=1 
let tagbar_width=32 
" tagbar 子窗口中不显示冗余帮助信息 
let g:tagbar_compact=1
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }


