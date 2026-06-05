set nocompatible

" vim-plug — install with:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugs')

Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'klen/python-mode'
Plug 'tpope/vim-surround'
Plug 'preservim/vim-markdown'

call plug#end()

filetype plugin indent on
syntax on

set clipboard=unnamed
set backspace=indent,eol,start
set mouse=a
set history=500
set tabpagemax=15
set showmode
set cursorline
set nu
set showmatch
set incsearch
set hlsearch
set whichwrap=b,s,h,l,<,>,[,]
set scrolljump=5
set scrolloff=3
set nofoldenable
set nobackup
set nowritebackup
set noswapfile
set encoding=utf-8

" formatting
set nowrap
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set pastetoggle=<F11>

autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 indentkeys-=<:>
autocmd FileType c,cpp,java,php,js,python,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

if has('cmdline_info')
    set ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set showcmd
endif

" leader and navigation
let mapleader = ','
nnoremap ; :
nnoremap j gj
nnoremap k gk
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_
vnoremap < <gv
vnoremap > >gv
nmap <silent> <leader>/ :nohlsearch<CR>

" F-keys
map <F2> :NERDTreeToggle<CR>
map <F12> :PlugInstall<CR>

" Python
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'
let g:pymode_lint = 1
let g:pymode_lint_write = 1
let g:pymode_virtualenv = 1
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_folding = 0

augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Orange
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
augroup END

set laststatus=2

if has('gui_running')
    highlight Pmenu guibg=#cccccc gui=bold
endif

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
